import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/common/views/page_under_construction.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/services/injection_container.dart';
import 'package:todo_app/src/features/auth/data/datasources/cache_local_data_source.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';
import 'package:todo_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todo_app/src/features/auth/presentation/views/sign_in_screen.dart';
import 'package:todo_app/src/features/auth/presentation/views/sign_up_screen.dart';
import 'package:todo_app/src/features/dashboard/presentation/views/dashboard.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();

      return _pageBuilder((context) {
        if (sl<FirebaseAuth>().currentUser != null  || (prefs.getBool(isUserLoggedIn) ?? false)) {
          final user = sl<FirebaseAuth>().currentUser!;
          final currentUser = LocalUser(
              uid: user.uid,
              email: user.email ?? '',
              fullName: user.displayName ?? '',
              );
          context.userProvider.initUser(currentUser);
          return const Dashboard();
        }
        return BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        );
      }, settings: settings);

    case SignInScreen.routeName:
      return _pageBuilder(
          (_) => BlocProvider(
                create: (_) => sl<AuthBloc>(),
                child: const SignInScreen(),
              ),
          settings: settings);


    case SignUpScreen.routeName:
      return _pageBuilder(
          (_) => BlocProvider(
                create: (_) => sl<AuthBloc>(),
                child: const SignUpScreen(),
              ),
          settings: settings);

    case Dashboard.routeName:
      return _pageBuilder((_) => const Dashboard(), settings: settings);


    default:
      return _pageBuilder(
          (_) => const PageUnderConstruction(),
          settings: settings);
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext context) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
