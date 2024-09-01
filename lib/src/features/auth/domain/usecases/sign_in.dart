import 'package:equatable/equatable.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';
import 'package:todo_app/src/features/auth/domain/repos/auth_repo.dart';

class SignIn extends UseCaseWithParams<void, SignInParams> {
  const SignIn(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) =>
      _authRepo.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  final String email;
  final String password;

  const SignInParams.empty() : this(email: '', password: '');

  @override
  List<Object?> get props => [email, password];
}
