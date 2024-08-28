import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/enums/update_user.dart';
import 'package:todo_app/src/features/auth/domain/repos/auth_repo.dart';
import 'package:todo_app/src/features/auth/domain/usecases/update_user.dart';

import 'auth_repo_mock.dart';

void main() {
  late AuthRepo authRepo;
  late UpdateUser updateUser;
  const tUpdateUserParams = UpdateUserParams.empty();
  const tUpdateUserAction = UpdateUserAction.lastDataSync;

  setUp(() {
    authRepo = MockAuthRepo();
    updateUser = UpdateUser(authRepo);
    registerFallbackValue(tUpdateUserParams);
    registerFallbackValue(tUpdateUserAction);
  });



  test('should call [authRepo.updateUserData] then return void', () async {
    when(() => authRepo.updateUserData(action: any(named: 'action'),userData: any(named: 'userData')))
        .thenAnswer((_) async => const Right(null));

    final result = await updateUser
        .call(tUpdateUserParams);


    expect(result, equals(const Right(null)) );

    verify(() => authRepo.updateUserData(action: tUpdateUserParams.action, userData: tUpdateUserParams.userData)).called(1);
    verifyNoMoreInteractions(authRepo);
  });
}
