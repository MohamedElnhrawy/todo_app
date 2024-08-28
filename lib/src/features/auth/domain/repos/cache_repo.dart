import 'package:todo_app/core/utils/typedefs.dart';

abstract class CacheRepo {
  const CacheRepo();
  VoidFuture cacheUserLoggedIn(bool status);
  ResultFuture<bool> checkIfUserLoggedIn();
}