import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/errors/exceptions.dart';
abstract class CacheLocalDataSource {
  const CacheLocalDataSource();
  Future<void> cacheUserLoggedIn(bool status);
  Future<bool> checkIfUserLoggedIn();
}

const isUserLoggedIn = 'isUserLoggedIn';

class CacheLocalDataSourceImpl extends CacheLocalDataSource{
  const CacheLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> cacheUserLoggedIn(bool status) async {
    try{
      await _prefs.setBool(isUserLoggedIn, status);
    }catch(e){
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserLoggedIn() {
   try{
     return  Future.value(_prefs.getBool(isUserLoggedIn) ?? false);
   }catch(e){
     throw CacheException(message: e.toString());

   }
  }

}


