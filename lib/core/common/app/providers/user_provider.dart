import 'package:flutter/material.dart';
import 'package:todo_app/src/features/auth/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  LocalUser? _user;

  LocalUser? get user => _user;

  void initUser(LocalUser user) {
    if (user != _user) _user = user;
  }

  set user(LocalUser? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero,
          notifyListeners); // make some delay so screens could be build to over come rebuild during build issue if changes notified.
    }
  }
}
