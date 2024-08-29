import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/common/app/locale/data/datasources/locale_data_source.dart';
import 'package:todo_app/core/common/app/locale/data/repos/locale_repo_impl.dart';
import 'package:todo_app/core/common/app/locale/domain/repos/locale_repo.dart';
import 'package:todo_app/core/common/app/locale/domain/usecases/get_locale.dart';
import 'package:todo_app/core/common/app/locale/domain/usecases/set_locale.dart';
import 'package:todo_app/core/common/app/locale/presentation/providers/locale_provider.dart';
import 'package:todo_app/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:todo_app/src/features/auth/data/datasources/cache_local_data_source.dart';
import 'package:todo_app/src/features/auth/data/repos/auth_repo_impl.dart';
import 'package:todo_app/src/features/auth/data/repos/cache_repo_impl.dart';
import 'package:todo_app/src/features/auth/domain/repos/auth_repo.dart';
import 'package:todo_app/src/features/auth/domain/repos/cache_repo.dart';
import 'package:todo_app/src/features/auth/domain/usecases/cache_user_login.dart';
import 'package:todo_app/src/features/auth/domain/usecases/check_user_login.dart';
import 'package:todo_app/src/features/auth/domain/usecases/sign_in.dart';
import 'package:todo_app/src/features/auth/domain/usecases/sign_up.dart';
import 'package:todo_app/src/features/auth/domain/usecases/update_user.dart';
import 'package:todo_app/src/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;
late SharedPreferences prefs;

Future<void> init() async {
  await _initAppLocale();
  await _initAuth();
}

Future<void> _initAppLocale() async {
  prefs = await SharedPreferences.getInstance(); // on top as it must be awaited
  sl.registerFactory(() => LocaleProvider(getLocale: sl(), setLocale: sl()));
  sl.registerLazySingleton(() => GetLocale(sl()));
  sl.registerLazySingleton(() => SetLocale(sl()));
  sl.registerLazySingleton<LocaleRepo>(
      () => LocaleRepoImpl(localeDataSource: sl()));
  sl.registerLazySingleton<LocaleDataSource>(() => LocaleDataSourceImpl(sl()));
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
}

Future<void> _initAuth() async {
  sl.registerFactory(() => AuthBloc(
      signIn: sl(),
      signUp: sl(),
      updateUser: sl(),
      checkUserLogin: sl(),
      cacheUserLogin: sl()));
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => SignUp(sl()));
  sl.registerLazySingleton(() => UpdateUser(sl()));
  sl.registerLazySingleton(() => CheckUserLogin(sl()));
  sl.registerLazySingleton(() => CacheUserLogin(sl()));
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(authRepoDataSource: sl()));
  sl.registerLazySingleton<CacheRepo>(
      () => CacheRepoImpl(cacheLocalDataSource: sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(), firebaseStorage: sl(), firebaseFireStore: sl()));

  sl.registerLazySingleton<CacheLocalDataSource>(
      () => CacheLocalDataSourceImpl(sl()));

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}
