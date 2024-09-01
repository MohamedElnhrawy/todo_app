import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/src/features/auth/domain/repos/cache_repo.dart';
import 'package:todo_app/src/features/auth/domain/usecases/cache_user_login.dart';

import 'cache_repo_mock.dart';

void main(){

  late CacheRepo cacheRepo;
  late CacheUserLogin cacheUserLogin;

  setUp((){
    cacheRepo = MockCacheRepo();
    cacheUserLogin = CacheUserLogin(cacheRepo);
  });

  group('cacheUserLoggedIn', (){

    // success case
    test('should call [cacheRepo.cacheUserLoggedIn] then success', () async {
    // arrange
      when(() => cacheRepo.cacheUserLoggedIn(any())).thenAnswer((_) async =>
          const Right(null));

      //act
      final result = await cacheUserLogin.call(true);

      // assert
      expect(result, equals(const Right(null)) );

      verify(() => cacheRepo.cacheUserLoggedIn(true)).called(1);
      verifyNoMoreInteractions(cacheRepo);

    });


    // exception case
    test('should call [cacheRepo.cacheUserLoggedIn] then fail', () async {
      when(() => cacheRepo.cacheUserLoggedIn(any())).thenAnswer((_) async =>
          Left(CacheFailure(message: "message", statusCode: "statusCode")));

      //act
      final result = await cacheUserLogin.call(true);

      // assert
      expect(result, equals(
          Left(CacheFailure(message: 'message', statusCode: 'statusCode'))));

      verify(() => cacheRepo.cacheUserLoggedIn(true)).called(1);
      verifyNoMoreInteractions(cacheRepo);

    });


  });




}