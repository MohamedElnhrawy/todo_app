import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/auth/domain/repos/cache_repo.dart';

class CacheUserLogin extends UseCaseWithParams<void,bool> {
  const CacheUserLogin(this._cacheRepo);

  final CacheRepo _cacheRepo;

  @override
  ResultFuture<void> call(bool params) => _cacheRepo.cacheUserLoggedIn(params);
}
