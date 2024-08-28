import 'package:equatable/equatable.dart';
import 'package:todo_app/core/enums/update_user.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/auth/domain/repos/auth_repo.dart';

class UpdateUser extends UseCaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _authRepo.updateUserData(
      action: params.action, userData: params.userData);
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  final dynamic userData;
  final UpdateUserAction action;

  const UpdateUserParams.empty()
      : this(action: UpdateUserAction.lastDataSync, userData: '');

  @override
  List<Object?> get props => [action, userData];
}
