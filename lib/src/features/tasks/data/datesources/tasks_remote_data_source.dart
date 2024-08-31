import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/errors/exceptions.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/src/features/tasks/data/models/task.dart';

abstract class TasksRemoteDataSource {
  const TasksRemoteDataSource();

  Future<List<TaskModel>> getTasks();

  Future<void> addTask(TaskModel task);
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  const TasksRemoteDataSourceImpl(
      {required FirebaseFirestore fireStore, required FirebaseAuth auth})
      : _fireStore = fireStore,
        _auth = auth;

  final FirebaseFirestore _fireStore;
  final FirebaseAuth _auth;

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
            message: 'User not Authorized', statusCode: '401');
      }

      String userId = _auth.currentUser!.uid;

      await _fireStore
          .collection(AppConstants.storeUsersCollection)
          .doc(userId)
          .collection(AppConstants.storeTasksCollection)
          .doc(task.id)
          .set(task.toMap());
      // .add(task.toMap());

      return Future.value();
    } on FirebaseException catch (e) {
      throw ServerException(
          message: e.message ?? 'Unknown error', statusCode: e.code);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
            message: 'User not Authorized', statusCode: '401');
      }

      String userId = _auth.currentUser!.uid;

      final querySnapshot = await _fireStore
          .collection(AppConstants.storeUsersCollection)
          .doc(userId)
          .collection(AppConstants.storeTasksCollection)
          .get();

      return querySnapshot.docs
          .map((doc) => TaskModel.fromFireStore(doc.id, doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(
          message: e.message ?? 'Unknown error', statusCode: e.code);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '500');
    }
  }
}
