import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/errors/exceptions.dart';
import 'package:todo_app/src/features/auth/data/datasources/cache_local_data_source.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main(){
  late SharedPreferences prefs;
  late CacheLocalDataSource cacheLocalDataSource;
  
  
  setUp((){
    prefs = MockSharedPreferences();
    cacheLocalDataSource = CacheLocalDataSourceImpl(prefs);
  });


  group('cache first time [cacheFirstTime] ', () {
    test('should call [pref] and completes success', () async {
      when(() => prefs.setBool(any(), any())).thenAnswer((_) async => false);
      final result =  cacheLocalDataSource.cacheUserLoggedIn(true);
      expect(result, completes);
      verify(() => prefs.setBool(isUserLoggedIn, true)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should throw cacheException', () async {
      when(() => prefs.setBool(any(), any())).thenThrow(Exception());
      final methodCall =  cacheLocalDataSource.cacheUserLoggedIn(true);
      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => prefs.setBool(isUserLoggedIn, true)).called(1);
      verifyNoMoreInteractions(prefs);
    });

  });



  group('check checkIfUserFirstTime [checkIfUserFirstTime] ', () {
    test('should call [pref] and completes success', () async {
      when(() => prefs.getBool(any())).thenReturn(true);
      final result =  await cacheLocalDataSource.checkIfUserLoggedIn();
      expect(result, true);
      verify(() => prefs.getBool(isUserLoggedIn)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should throw cacheException', () async {
      when(() => prefs.getBool(any())).thenThrow(Exception());
      final methodCall =  cacheLocalDataSource.checkIfUserLoggedIn;
      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => prefs.getBool(isUserLoggedIn)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });
  
}
 