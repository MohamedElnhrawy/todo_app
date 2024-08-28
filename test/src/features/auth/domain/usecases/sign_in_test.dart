import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';
import 'package:todo_app/src/features/auth/domain/repos/auth_repo.dart';
import 'package:todo_app/src/features/auth/domain/usecases/sign_in.dart';

import 'auth_repo_mock.dart';

void main() {
  late AuthRepo authRepo;
  late SignIn signIn;

  setUp(() {
    authRepo = MockAuthRepo();
    signIn = SignIn(authRepo);
  });

  const tUser = LocalUser.empty();
  const tEmail = 'email';
  const tPassword = 'password';

  test('should call [authRepo.signIn] then return LocalUser model', () async {
    when(() => authRepo.signIn(
            email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async => const Right(tUser));

    final result = await signIn
        .call(const SignInParams(email: tEmail, password: tPassword));
    
    expect(result, const Right<dynamic,LocalUser>(tUser));
    
    verify(() => authRepo.signIn(email: tEmail, password: tPassword)).called(1);
    verifyNoMoreInteractions(authRepo);
  });
}
