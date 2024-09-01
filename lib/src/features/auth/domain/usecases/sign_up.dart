import 'package:equatable/equatable.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/auth/domain/repos/auth_repo.dart';

class SignUp extends UseCaseWithParams<void, SignUpParams> {
  const SignUp(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(SignUpParams params) =>
      _authRepo.signUp(fullName: params.fullName,email: params.email, password: params.password);
}

class SignUpParams extends Equatable {
  const SignUpParams({required this.email, required this.password, required this.fullName});

  final String email;
  final String password;
  final String fullName;

  const SignUpParams.empty() : this(email: '', password: '',fullName: '');

  @override
  List<Object?> get props => [email, password];
}
