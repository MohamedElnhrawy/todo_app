import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';
import 'package:todo_app/src/features/auth/domain/usecases/cache_user_login.dart';
import 'package:todo_app/src/features/auth/domain/usecases/check_user_login.dart';
import 'package:todo_app/src/features/auth/domain/usecases/sign_in.dart';
import 'package:todo_app/src/features/auth/domain/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required CheckUserLogin checkUserLogin,
    required CacheUserLogin cacheUserLogin,
  })  : _signIn = signIn,
        _signingUp = signUp,
        _cacheUserLogin = cacheUserLogin,
        _checkUserLogin = checkUserLogin,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // for all events
      emit(const AuthLoading()); // for all event emit loading state
    });

    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<CacheUserLoggedInEvent>(_cacheUserLoggedInHandler);
    on<CheckUserLoggedInEvent>(_checkUserLoggedInHandler);
  }

  // use-cases dependencies
  final SignIn _signIn;
  final SignUp _signingUp;
  final CheckUserLogin _checkUserLogin;
  final CacheUserLogin _cacheUserLogin;

  Future<void> _signInHandler(
      SignInEvent event, Emitter<AuthState> emit) async {
    final result = await _signIn
        .call(SignInParams(email: event.email, password: event.password));

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(SignedInSuccess(user)),
    );
  }

  Future<void> _signUpHandler(
      SignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signingUp.call(SignUpParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName));

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const SignedUpSuccess()),
    );
  }


  Future<void> _cacheUserLoggedInHandler(
      CacheUserLoggedInEvent event, Emitter<AuthState> emit) async {
    final result = await _cacheUserLogin.call(event.status);

    result.fold(
      (failure) => emit(CachingError(failure.errorMessage)),
      (_) => emit(const UserLoggedInCached()),
    );
  }

  Future<void> _checkUserLoggedInHandler(
      CheckUserLoggedInEvent event, Emitter<AuthState> emit) async {
    final result = await _checkUserLogin.call();

    result.fold(
      (failure) => emit(CachingError(failure.errorMessage)),
      (status) => emit(UserLoggedInStatus(status)),
    );
  }
}
