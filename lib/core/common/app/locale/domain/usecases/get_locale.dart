import 'package:todo_app/core/common/app/locale/domain/repos/locale_repo.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/core/utils/typedefs.dart';

class GetLocale extends UseCase<String> {
  const GetLocale(this._localeRepo);

  final LocaleRepo _localeRepo;

  @override
  ResultFuture<String> call() => _localeRepo.getLocale();
}
