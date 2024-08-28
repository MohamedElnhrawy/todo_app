import 'package:dartz/dartz.dart';
import 'package:todo_app/core/enums/update_user.dart';
import 'package:todo_app/core/errors/exceptions.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';
import 'package:todo_app/src/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  const AuthRepoImpl({required this.authRepoDataSource});

  final AuthRemoteDataSource authRepoDataSource;


  @override
  ResultFuture<LocalUser> signIn(
      {required String email, required String password}) async {
    try {
      final result =
          await authRepoDataSource.signIn(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 505));
    }
  }

  @override
  VoidFuture signUp(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      await authRepoDataSource.signUp(
          fullName: fullName, email: email, password: password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 505));
    }
  }

  @override
  VoidFuture updateUserData(
      {required UpdateUserAction action, required dynamic userData}) async {
    try {
      await authRepoDataSource.updateUserData(
          action: action, userData: userData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 505));
    }
  }
}
