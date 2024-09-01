import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/src/features/auth/domain/repos/cache_repo.dart';
import 'package:todo_app/src/features/auth/domain/usecases/check_user_login.dart';

import 'cache_repo_mock.dart';

void main(){
  late CacheRepo cacheRepo;
  late CheckUserLogin checkUserLogin;

  setUp((){
    cacheRepo = MockCacheRepo();
    checkUserLogin = CheckUserLogin(cacheRepo);
  });

  group('checkUserLoggedIn', () {

    // success case
    test('should call [cacheRepo.checkIfUserLoggedIn] then success', () async {
      when(() => cacheRepo.checkIfUserLoggedIn()).thenAnswer((_) async =>
      const Right(false));

      //act
      final result = await checkUserLogin.call();

      // assert
      expect(result, equals(const Right(false)) );

      verify(() => cacheRepo.checkIfUserLoggedIn()).called(1);
      verifyNoMoreInteractions(cacheRepo);

    });


    // exception case
    test('should call [cacheRepo.checkIfUserLoggedIn] then fail', () async {
      when(() => cacheRepo.checkIfUserLoggedIn()).thenAnswer((_) async =>
          Left(CacheFailure(message: "message", statusCode: "statusCode")));

      //act
      final result = await checkUserLogin.call();

      // assert
      expect(result, equals(
          Left(CacheFailure(message: 'message', statusCode: 'statusCode'))));

      verify(() => cacheRepo.checkIfUserLoggedIn()).called(1);
      verifyNoMoreInteractions(cacheRepo);

    });


  });


}