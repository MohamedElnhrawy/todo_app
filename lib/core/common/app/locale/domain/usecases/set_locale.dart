import 'package:todo_app/core/common/app/locale/domain/repos/locale_repo.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/core/utils/typedefs.dart';

class SetLocale extends UseCaseWithParams<void,String> {
  const SetLocale(this._localeRepo);

  final LocaleRepo _localeRepo;

  @override
  ResultFuture<void> call(String params) => _localeRepo.setLocale(params);
}
