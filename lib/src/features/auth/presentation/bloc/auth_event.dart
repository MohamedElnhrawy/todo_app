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

class UpdateUserDataEvent extends AuthEvent {
  UpdateUserDataEvent({required this.action, required this.data})
      : assert(data is String || data is File || data is DataMap,
            "update data can't be [${data.runtimeType}]");

  final UpdateUserAction action;
  final dynamic data;

  @override
  List<Object?> get props => [action, data];
}

class CacheUserLoggedInEvent extends AuthEvent {
  const CacheUserLoggedInEvent(this.status);
  final bool status;


}

class CheckUserLoggedInEvent extends AuthEvent {
  const CheckUserLoggedInEvent();
}
