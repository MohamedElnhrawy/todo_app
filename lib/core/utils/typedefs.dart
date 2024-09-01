
import 'package:dartz/dartz.dart';
import 'package:todo_app/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure,T>>;
typedef VoidFuture = ResultFuture<void>;
typedef DataMap = Map<String,dynamic>;