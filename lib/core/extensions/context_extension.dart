import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/common/app/providers/tab_navigator.dart';

extension ContectEx on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  TabNavigator get tabNavigator => read<TabNavigator>();

  void pop() => tabNavigator.pop();
  void popToRoot() => tabNavigator.popToRoot();
  void popTo(Widget page) => tabNavigator.popTo(TabItem(child: page));
  void popUntil(Widget page) => tabNavigator.popUntil(TabItem(child: page));
  void push(Widget page) => tabNavigator.push(TabItem(child: page));
  void pushAndRemoveUntil(Widget page) => tabNavigator.pushAndRemoveUntil(TabItem(child: page));

}