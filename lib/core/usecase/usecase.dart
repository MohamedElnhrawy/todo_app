
import 'package:todo_app/core/utils/typedefs.dart';

abstract class UseCaseWithParams<Type, Params>{
  const UseCaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UseCase<Type>{
  const UseCase();
  ResultFuture<Type> call();
}