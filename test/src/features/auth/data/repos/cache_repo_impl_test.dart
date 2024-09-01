import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/errors/exceptions.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/src/features/auth/data/datasources/cache_local_data_source.dart';
import 'package:todo_app/src/features/auth/data/repos/cache_repo_impl.dart';
import 'package:todo_app/src/features/auth/domain/repos/cache_repo.dart';

class MockCacheLocalDataSource extends Mock implements CacheLocalDataSource{}

void main() {
  
  late CacheLocalDataSource cacheLocalDataSource;
  late CacheRepoImpl cacheRepoImpl;
  
  
  setUp((){
    cacheLocalDataSource = MockCacheLocalDataSource();
    cacheRepoImpl = CacheRepoImpl(cacheLocalDataSource: cacheLocalDataSource);
  });

  test('should check a subclass of [CacheRepo]', () {
    expect(cacheRepoImpl, isA<CacheRepo>());
  });

  group('cache user login status', () {
    test('should complete successfully', () async {
      when(() => cacheLocalDataSource.cacheUserLoggedIn(any()))
          .thenAnswer((_) async => Future.value());
      // Act
      final result = await cacheRepoImpl.cacheUserLoggedIn(true);
      // Assert
      expect(result, equals(const Right(null)));

      verify(() => cacheLocalDataSource.cacheUserLoggedIn(true)).called(1);
      verifyNoMoreInteractions(cacheLocalDataSource);
    });

    // error
    test('should return [CacheFailure] Error', () async {
      when(() => cacheLocalDataSource.cacheUserLoggedIn(any())).thenThrow(
          const CacheException(message: 'message'));
      // Act
      final result = await cacheRepoImpl.cacheUserLoggedIn(true);
      // Assert
      expect(result,
          Left( CacheFailure(message: 'message', statusCode: 505)));

      verify(() => cacheLocalDataSource.cacheUserLoggedIn(true)).called(1);
      verifyNoMoreInteractions(cacheLocalDataSource);
    });
  });
  
}