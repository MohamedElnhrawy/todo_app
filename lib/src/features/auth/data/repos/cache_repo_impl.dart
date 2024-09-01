import 'package:dartz/dartz.dart';
import 'package:todo_app/core/errors/exceptions.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/auth/data/datasources/cache_local_data_source.dart';
import 'package:todo_app/src/features/auth/domain/repos/cache_repo.dart';

class CacheRepoImpl extends CacheRepo {

  CacheRepoImpl({ required this.cacheLocalDataSource});

  final CacheLocalDataSource cacheLocalDataSource;

  @override
  VoidFuture cacheUserLoggedIn(bool status) async {
    try{
      await cacheLocalDataSource.cacheUserLoggedIn(status);
      return const Right(null);
    }on CacheException catch(e){
      return Left(CacheFailure.fromException(e));
    }

  }

  @override
  ResultFuture<bool> checkIfUserLoggedIn() async {
    try{
      final result = await cacheLocalDataSource.checkIfUserLoggedIn();
      return  Right(result);
    }on CacheException  catch(e){
      return Left(CacheFailure.fromException(e));
    }
  }

}