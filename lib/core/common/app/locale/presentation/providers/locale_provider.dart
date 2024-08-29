import 'package:flutter/material.dart';
import 'package:todo_app/core/common/app/locale/domain/usecases/get_locale.dart';
import 'package:todo_app/core/common/app/locale/domain/usecases/set_locale.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider({required GetLocale getLocale, required SetLocale setLocale})
      : _getLocale = getLocale,
        _setLocale = setLocale {

    _initializeLocale();
  }

  final GetLocale _getLocale;
  final SetLocale _setLocale;
  late Locale _locale;


  Future<void> _initializeLocale() async {
    final result  = await _getLocale.call();
    result.fold((_) {} , (value) => _locale = Locale(value));
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _setLocale.call(locale.languageCode);
    notifyListeners();
  }

  Locale get locale => _locale;

}
