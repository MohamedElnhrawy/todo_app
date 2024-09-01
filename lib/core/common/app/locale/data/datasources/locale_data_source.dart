import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/errors/exceptions.dart';
import 'package:todo_app/core/utils/constants.dart';
abstract class LocaleDataSource {
  const LocaleDataSource();
  Future<void> setLocale(String locale);
  Future<String> getLocale();
}

const currentLanguage = 'currentLanguageKey';

class LocaleDataSourceImpl extends LocaleDataSource{
  const LocaleDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> setLocale(String locale) async {
    try{
      await _prefs.setString(currentLanguage, locale);
    }catch(e){
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<String> getLocale() {
    try{
      return  Future.value(_prefs.getString(currentLanguage) ?? AppConstants.EN);
    }catch(e){
      throw CacheException(message: e.toString());

    }
  }

}


