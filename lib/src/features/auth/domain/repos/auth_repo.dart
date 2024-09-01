import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<LocalUser> signIn(
      {required String email, required String password});

  VoidFuture signUp(
      {required String fullName,
        required String email,
        required String password});


}