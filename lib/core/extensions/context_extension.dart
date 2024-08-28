import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/common/app/providers/locale_provider.dart';
import 'package:todo_app/core/common/app/providers/tab_navigator.dart';
import 'package:todo_app/core/common/app/providers/user_provider.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/src/features/dashboard/presentation/providers/dashboard_controller.dart';

extension ContectEx on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  TabNavigator get tabNavigator => read<TabNavigator>();

  UserProvider get userProvider => read<UserProvider>();
  LocaleProvider get currentLocale => read<LocaleProvider>();

  LocalUser? get currentUser => userProvider.user;

  AppLocalizations get l10n => AppLocalizations.of(this);

  DashboardController get dashBoardController => read<DashboardController>();


  void pop() => tabNavigator.pop();
  void popToRoot() => tabNavigator.popToRoot();
  void popTo(Widget page) => tabNavigator.popTo(TabItem(child: page));
  void popUntil(Widget page) => tabNavigator.popUntil(TabItem(child: page));
  void push(Widget page) => tabNavigator.push(TabItem(child: page));
  void pushAndRemoveUntil(Widget page) => tabNavigator.pushAndRemoveUntil(TabItem(child: page));

}