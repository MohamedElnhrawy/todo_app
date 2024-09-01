part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  const SignInEvent({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent(
      {required this.fullName, required this.email, required this.password});

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object?> get props => [email, password, fullName];
}



class CacheUserLoggedInEvent extends AuthEvent {
  const CacheUserLoggedInEvent(this.status);
  final bool status;


}

class CheckUserLoggedInEvent extends AuthEvent {
  const CheckUserLoggedInEvent();
}
