import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/enums/update_user.dart';
import 'package:todo_app/core/errors/exceptions.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/auth/data/models/user.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<UserModel> signIn(
      {required String email, required String password});

  Future<void> signUp(
      {required String fullName,
        required String email,
        required String password});

  Future<void> updateUserData(
      {required UpdateUserAction action, required dynamic userData});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(
      {required FirebaseAuth firebaseAuth,
        required FirebaseStorage firebaseStorage,
        required FirebaseFirestore firebaseFireStore})
      : _firebaseAuth = firebaseAuth,
        _firebaseStorage = firebaseStorage,
        _firebaseFireStore = firebaseFireStore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firebaseFireStore;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      if (user == null) {
        throw const ServerException(
            message: 'Please try again later', statusCode: 'unknown Error');
      }

      var userData = await _getUserData(user.uid);
      if (userData.exists) {
        return UserModel.fromMap(userData.data()!);
      }
      // if user not exist then upload the data
      await _setUserData(user, email);
      userData = await _getUserData(user.uid);

      return UserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? 'error Occurred', statusCode: e.code);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> signUp(
      {required String fullName,
        required String email,
        required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userCredential.user?.updateDisplayName(fullName);
      await _setUserData(_firebaseAuth.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? 'error Occurred', statusCode: e.code);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> updateUserData({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.lastDataSync:
          await _updateUserData({'lastDataSync': userData as String});
      }
    } on FirebaseException catch (e) {
      throw ServerException(
          message: e.message ?? 'error Occurred', statusCode: e.code);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  // get user data from fire-store by uid
  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return await _firebaseFireStore.collection(AppConstants.storeUsersCollection).doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _firebaseFireStore
        .collection(AppConstants.storeUsersCollection)
        .doc(user.uid)
        .set(UserModel(
      uid: user.uid,
      email: user.email ?? fallbackEmail,
      fullName: user.displayName ?? '',
      lastDataSync: null,
    ).toMap());
  }

  Future<void> _updateUserData(DataMap data) async {
    await _firebaseFireStore
        .collection(AppConstants.storeUsersCollection)
        .doc(_firebaseAuth.currentUser?.uid)
        .update(data);
  }
}
