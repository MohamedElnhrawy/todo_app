import 'package:equatable/equatable.dart';
import 'package:todo_app/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
      : assert(statusCode is String || statusCode is int,
            "statusCode can't be ${statusCode.runtimeType}");

  final String message;
  final dynamic statusCode;

  @override
  List<Object?> get props => [message, statusCode];

  String get errorMessage {
    final showErrorText = statusCode is! String || int.tryParse(statusCode as String) != null;
    return '$statusCode ${showErrorText ? ' Error': ''} : $message';
  }
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});

  CacheFailure.fromException(CacheException e)
      : this(message: e.message, statusCode: e.statusCode);
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException e)
      : this(message: e.message, statusCode: e.statusCode);
}
