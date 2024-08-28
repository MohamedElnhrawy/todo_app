import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';
import 'package:todo_app/src/features/auth/domain/usecases/cache_user_login.dart';
import 'package:todo_app/src/features/auth/domain/usecases/check_user_login.dart';
import 'package:todo_app/src/features/auth/domain/usecases/sign_in.dart';
import 'package:todo_app/src/features/auth/domain/usecases/sign_up.dart';
import 'package:todo_app/src/features/auth/domain/usecases/update_user.dart';
import 'package:todo_app/src/features/auth/presentation/bloc/auth_bloc.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockUpdateUser extends Mock implements UpdateUser {}

class MockCheckUserLogin extends Mock implements CheckUserLogin {}

class MockCacheUserLogin extends Mock implements CacheUserLogin {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late UpdateUser updateUser;
  late CheckUserLogin checkUserLogin;
  late CacheUserLogin cacheUserLogin;
  late AuthBloc authBloc;

  const tSignUpParams = SignUpParams.empty();
  const tSignInParams = SignInParams.empty();
  const tUpdateUserParams = UpdateUserParams.empty();

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    updateUser = MockUpdateUser();
    checkUserLogin = MockCheckUserLogin();
    cacheUserLogin = MockCacheUserLogin();
    authBloc = AuthBloc(
        signIn: signIn,
        signUp: signUp,
        updateUser: updateUser,
        checkUserLogin: checkUserLogin,
        cacheUserLogin: cacheUserLogin);
  });

  setUpAll(() {
    registerFallbackValue(tSignUpParams);
    registerFallbackValue(tSignInParams);
    registerFallbackValue(tUpdateUserParams);
  });

  tearDown(() => authBloc
      .close()); // after each test teardown state so not effect next test

  final tServerFailure =
      ServerFailure(message: 'user not found', statusCode: 'statusCode');
final tCacheFailure =
      CacheFailure(message: 'user not found', statusCode: 'statusCode');

  test('initial should be [AuthInitial]', () async {
    expect(authBloc.state, const AuthInitial());
  });

  group('signIn', () {
    const tUser = LocalUser.empty();

    // success case
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedIn] when [SignInEvent] triggered success',
      build: () {
        when(() => signIn.call(any()))
            .thenAnswer((_) async => const Right(tUser));

        return authBloc;
      },
      act: (bloc) => bloc.add(SignInEvent(
          email: tSignInParams.email, password: tSignInParams.password)),
      expect: () => [const AuthLoading(), const SignedInSuccess(tUser)],
      verify: (_) {
        verify(() => signIn.call(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );

    // fail case
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when [SignInEvent] triggered fail',
      build: () {
        when(() => signIn.call(any()))
            .thenAnswer((_) async =>  Left(tServerFailure));

        return authBloc;
      },
      act: (bloc) => bloc.add(SignInEvent(
          email: tSignInParams.email, password: tSignInParams.password)),
      expect: () => [const AuthLoading(),  AuthError(tServerFailure.errorMessage)],
      verify: (_) {
        verify(() => signIn.call(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });



  group('updateUser', () {

    // success case
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, UserUpdated] when [UpdateUserDataEvent] triggered success',
      build: () {
        when(() => updateUser.call(any()))
            .thenAnswer((_) async => const Right(null));

        return authBloc;
      },
      act: (bloc) => bloc.add(UpdateUserDataEvent(action: tUpdateUserParams.action,data: tUpdateUserParams.userData)),
      expect: () => [const AuthLoading(), const UserUpdated()],
      verify: (_) {
        verify(() => updateUser.call(tUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );

    // fail case
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when [UpdateUserDataEvent] triggered fail',
      build: () {
        when(() => updateUser.call(any()))
            .thenAnswer((_) async =>  Left(tServerFailure));

        return authBloc;
      },
      act: (bloc) => bloc.add(UpdateUserDataEvent(action: tUpdateUserParams.action,data: tUpdateUserParams.userData)),
      expect: () => [const AuthLoading(),  AuthError(tServerFailure.errorMessage)],
      verify: (_) {
        verify(() => updateUser.call(tUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );
  });

  group('signUp', () {

    // success case
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedUpSuccess] when [SignUpEvent] triggered success',
      build: () {
        when(() => signUp.call(any()))
            .thenAnswer((_) async => const Right(null));

        return authBloc;
      },
      act: (bloc) => bloc.add(SignUpEvent(fullName: tSignUpParams.fullName,email: tSignUpParams.email,password: tSignUpParams.password)),
      expect: () => [const AuthLoading(), const SignedUpSuccess()],
      verify: (_) {
        verify(() => signUp.call(tSignUpParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );

    // fail case
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when [SignUpEvent] triggered fail',
      build: () {
        when(() => signUp.call(any()))
            .thenAnswer((_) async =>  Left(tServerFailure));

        return authBloc;
      },
      act: (bloc) => bloc.add(SignUpEvent(fullName: tSignUpParams.fullName,email: tSignUpParams.email,password: tSignUpParams.password)),
      expect: () => [const AuthLoading(),  AuthError(tServerFailure.errorMessage)],
      verify: (_) {
        verify(() => signUp.call(tSignUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
  });


  group('cacheUser', () {

    // success case
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, UserLoggedInCached] when [CacheUserLoggedInEvent] triggered success',
      build: () {
        when(() => cacheUserLogin.call(any()))
            .thenAnswer((_) async => const Right(null));

        return authBloc;
      },
      act: (bloc) => bloc.add(const CacheUserLoggedInEvent(true)),
      expect: () => [const AuthLoading(), const UserLoggedInCached()],
      verify: (_) {
        verify(() => cacheUserLogin.call(true)).called(1);
        verifyNoMoreInteractions(cacheUserLogin);
      },
    );

    // fail case
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, CachingError] when [CacheUserLoggedInEvent] triggered fail',
      build: () {
        when(() => cacheUserLogin.call(any()))
            .thenAnswer((_) async =>  Left(tCacheFailure));

        return authBloc;
      },
      act: (bloc) => bloc.add(const CacheUserLoggedInEvent(true)),
      expect: () => [const AuthLoading(),  CachingError(tCacheFailure.errorMessage)],
      verify: (_) {
        verify(() => cacheUserLogin.call(true)).called(1);
        verifyNoMoreInteractions(cacheUserLogin);
      },
    );
  });

  group('checkUserLoggedIn', () {

    // success case
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, UserLoggedInCached] when [CheckUserLoggedInEvent] triggered success',
      build: () {
        when(() => checkUserLogin.call())
            .thenAnswer((_) async => const Right(true));

        return authBloc;
      },
      act: (bloc) => bloc.add(const CheckUserLoggedInEvent()),
      expect: () => [const AuthLoading(), const UserLoggedInStatus(true)],
      verify: (_) {
        verify(() => checkUserLogin.call()).called(1);
        verifyNoMoreInteractions(checkUserLogin);
      },
    );

    // fail case
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, CachingError] when [CheckUserLoggedInEvent] triggered fail',
      build: () {
        when(() => checkUserLogin.call())
            .thenAnswer((_) async =>  Left(tCacheFailure));

        return authBloc;
      },
      act: (bloc) => bloc.add(const CheckUserLoggedInEvent()),
      expect: () => [const AuthLoading(),  CachingError(tCacheFailure.errorMessage)],
      verify: (_) {
        verify(() => checkUserLogin.call()).called(1);
        verifyNoMoreInteractions(checkUserLogin);
      },
    );
  });

}
