import 'package:dartz/dartz.dart';
import 'package:todo_app/core/common/app/locale/data/datasources/locale_data_source.dart';
import 'package:todo_app/core/common/app/locale/domain/repos/locale_repo.dart';
import 'package:todo_app/core/errors/exceptions.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/utils/typedefs.dart';

class LocaleRepoImpl extends LocaleRepo {

  const LocaleRepoImpl({required this.localeDataSource});

  final LocaleDataSource localeDataSource;

  @override
  VoidFuture setLocale(String locale) async {
    try{
      await localeDataSource.setLocale(locale);
      return const Right(null);
    }on CacheException catch(e){
      return Left(CacheFailure.fromException(e));
    }

  }

  @override
  ResultFuture<String> getLocale() async {
    try{
      final result = await localeDataSource.getLocale();
      return  Right(result);
    }on CacheException  catch(e){
      return Left(CacheFailure.fromException(e));
    }
  }

}