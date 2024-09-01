import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/auth/domain/repos/cache_repo.dart';

class CheckUserLogin extends UseCase<bool> {
  const CheckUserLogin(this._cacheRepo);

  final CacheRepo _cacheRepo;

  @override
  ResultFuture<bool> call() => _cacheRepo.checkIfUserLoggedIn();
}
