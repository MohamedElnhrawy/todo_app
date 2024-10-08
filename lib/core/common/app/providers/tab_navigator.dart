import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TabNavigator extends ChangeNotifier {
  TabNavigator(this._initialPage) {
    _navigationStack.add(_initialPage);
  }

  final TabItem
      _initialPage; // first page in order we need to pop till first page

  final List<TabItem> _navigationStack = [];

  TabItem get currentPage => _navigationStack.last;

  void push(TabItem page) {
    _navigationStack.add(page);
    notifyListeners();
  }

  void pop() {
    if (_navigationStack.length > 1) _navigationStack.removeLast();
    notifyListeners();
  }

  void popToRoot() {
    _navigationStack.clear();
    _navigationStack.add(_initialPage);
    notifyListeners();
  }

  void popTo(TabItem page) {
    _navigationStack.remove(page);
    notifyListeners();
  }

  void popUntil(TabItem? page) {
    if (page == null) popToRoot();
    if (_navigationStack.length > 1) {
      _navigationStack.removeRange(1, _navigationStack.indexOf(page!) + 1);
      notifyListeners();
    }
  }

  void pushAndRemoveUntil(TabItem page) {
    _navigationStack.clear();
    _navigationStack.add(page);
    notifyListeners();
  }
}

class TabItem extends Equatable {
  TabItem({required this.child}) : id = const Uuid().v1();
  final Widget child;
  final String id;

  @override
  List<Object?> get props => [id];
}

class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {
  const TabNavigatorProvider(
      {required this.navigator, required super.child, required super.key})
      : super(notifier: navigator);

  final TabNavigator navigator;

  static TabNavigator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
        ?.navigator;
  }
}
