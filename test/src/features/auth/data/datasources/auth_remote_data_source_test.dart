
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/src/features/auth/data/datasources/auth_remote_data_source.dart';

Future<void> main() async {

  late FakeFirebaseFirestore fireStore;
  late MockFirebaseAuth auth;
  late MockFirebaseStorage storage;
  late AuthRemoteDataSource dataSource;

  setUp(() async {
    fireStore = FakeFirebaseFirestore();
    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Sign in.
    final mockUser = MockUser(
      uid: 'uid',
      email: 'mohamed.saad@test.com',
      displayName: 'Mohamed Saad',
    );
    auth = MockFirebaseAuth(mockUser: mockUser);
    final result = await auth.signInWithCredential(credential);
    final user =  result.user;
    debugPrint(mockUser.displayName);
    debugPrint(user?.displayName);

    storage = MockFirebaseStorage();

    dataSource = AuthRemoteDataSourceImpl(firebaseAuth: auth, firebaseStorage: storage, firebaseFireStore: fireStore);

  });

  const tPassword = "password";
  const tEmail = "saad@test.com";
  const tFullName = "Mohamed Saad Alnahrawy";

  test('signUp', () async {

    // act
    await dataSource.signUp(fullName: tFullName, email: tEmail, password: tPassword);

    //assert
    expect(auth.currentUser, isNotNull);
    expect(auth.currentUser!.displayName , tFullName);
    
    final user = await fireStore.collection(AppConstants.storeUsersCollection).doc(auth.currentUser!.uid).get();
    expect(user.exists, isTrue);

  });
  
  test('signIn', () async {
    await auth.signOut();
    await dataSource.signUp(fullName: tFullName,email: 'newEmail@email.com', password: tPassword);
    await dataSource.signIn(email: 'newEmail@email.com', password: tPassword);

    expect(auth.currentUser, isNotNull);
    expect(auth.currentUser!.email , equals("newEmail@email.com"));

  });

}