
import 'package:todo_app/core/utils/typedefs.dart';

abstract class LocaleRepo {
  const LocaleRepo();
  VoidFuture setLocale(String locale);
  ResultFuture<String> getLocale();
}