import 'package:base/domain/error/error_entity.dart';

sealed class ApiError extends ErrorEntity {
  final int? statusCode;
  final dynamic message;
  ApiError(super.originalException, {this.statusCode, this.message});

  String get errorMessage {
    if (message is String) {
      return message as String;
    } else if (message is Map) {
      final errorMap = message as Map<String, dynamic>;
      return errorMap.values.join(', ');
    }
    return 'Unknown error occurred';
  }

  String? getFieldError(String field) {
    if (message is Map) {
      final errorMap = message as Map<String, dynamic>;
      return errorMap[field]?.toString();
    }
    return null;
  }
}

class HttpError extends ApiError {
  HttpError(super.originalException, {super.statusCode, super.message});
}

class ServerError extends ApiError {
  ServerError(super.originalException, {super.statusCode, super.message});
}

class NetworkError extends ApiError {
  NetworkError(super.originalException, {super.statusCode, super.message});
}

class UnexpectedError extends ApiError {
  UnexpectedError(super.originalException, {super.statusCode, super.message});
}
