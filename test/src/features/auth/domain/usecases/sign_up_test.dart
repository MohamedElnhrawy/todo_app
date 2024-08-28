import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/src/features/auth/domain/repos/auth_repo.dart';
import 'package:todo_app/src/features/auth/domain/usecases/sign_up.dart';

import 'auth_repo_mock.dart';

void main() {
  late AuthRepo authRepo;
  late SignUp signUp;

  setUp(() {
    authRepo = MockAuthRepo();
    signUp = SignUp(authRepo);
  });

  const tEmail = 'email';
  const tPassword = 'password';
  const tFullName = 'name';

  test('should call [authRepo.signUp] then return void', () async {
    when(() => authRepo.signUp(fullName: any(named: 'fullName'),
        email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async => const Right(null));

    final result = await signUp
        .call(const SignUpParams(fullName:tFullName ,email: tEmail, password: tPassword));

    expect(result, equals(const Right(null)) );

    verify(() => authRepo.signUp(fullName: tFullName,email: tEmail, password: tPassword)).called(1);
    verifyNoMoreInteractions(authRepo);
  });
}
