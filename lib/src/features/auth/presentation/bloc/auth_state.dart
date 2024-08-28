part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class SignedInSuccess extends AuthState {
  const SignedInSuccess(this.user);

  final LocalUser user;

  @override
  List<Object> get props => [user.uid, user.email];
}

class SignedUpSuccess extends AuthState {
  const SignedUpSuccess();
}

class UserUpdated extends AuthState {
  const UserUpdated();
}

class UserLoggedInCached extends AuthState {
  const UserLoggedInCached();
}

class UserLoggedInStatus extends AuthState {
  const UserLoggedInStatus(this.status);

  final bool status;

  @override
  List<Object> get props => [status];
}

class CachingError extends AuthState {
  const CachingError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
