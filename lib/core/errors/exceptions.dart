import 'package:equatable/equatable.dart';

abstract class Exceptions extends Equatable implements Exception{
   const Exceptions({required this.message,required this.statusCode});
  final String message;
  final dynamic statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerException extends Exceptions{
  const ServerException({required super.message, required super.statusCode});

}
class CacheException extends Exceptions{
  const CacheException({required super.message,  super.statusCode = 505});
}