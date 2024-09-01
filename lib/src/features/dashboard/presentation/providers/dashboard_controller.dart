import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/common/app/providers/tab_navigator.dart';
import 'package:todo_app/core/common/views/persistent_view.dart';
import 'package:todo_app/core/services/injection_container.dart';
import 'package:todo_app/src/features/profile/presentation/views/profile_screen.dart';
import 'package:todo_app/src/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_app/src/features/tasks/presentation/views/add_task_screen.dart';
import 'package:todo_app/src/features/tasks/presentation/views/tasks_screen.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child:  BlocProvider(
            create: (_) => sl<TasksBloc>(),
            child: const TasksScreen(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: BlocProvider(
            create: (_) => sl<TasksBloc>(),
            child: const AddTaskScreen(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const ProfileScreen(),
        ),
      ),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
