import 'package:base/data/model/api_error_response.dart';
import 'package:base/data/repository/source/remote/api/error/api_error.dart';
import 'package:base/domain/error/error_entity.dart';
import 'package:base/domain/error/error_mapper.dart';
import 'package:dio/dio.dart';

class ApiErrorMapper extends ErrorMapper {
  ApiErrorMapper._();

  static final ApiErrorMapper instance = ApiErrorMapper._();

  @override
  ErrorEntity map(Object? exception) {
    if (exception is DioException) {
      final errorResponse = _parseApiErrorResponse(exception);
      final statusCode = exception.response?.statusCode ?? 0;
      final message = errorResponse?.message ?? _getDefaultMessage(exception.type);

      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.connectionError:
          return NetworkError(
            exception,
            statusCode: statusCode,
            message: message,
          );
        case DioExceptionType.badResponse:
          if (statusCode >= 500) {
            return ServerError(
              exception,
              statusCode: statusCode,
              message: message,
            );
          }
          return HttpError(
            exception,
            statusCode: statusCode,
            message: message,
          );
        case DioExceptionType.unknown:
        default:
          return UnexpectedError(
            exception,
            statusCode: statusCode,
            message: message,
          );
      }
    }

    return UnexpectedError(exception);
  }

  ApiErrorResponse? _parseApiErrorResponse(DioException exception) {
    try {
      final responseData = exception.response?.data;
      if (responseData is Map<String, dynamic>) {
        return ApiErrorResponse.fromJson(responseData);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  String _getDefaultMessage(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return 'Không thể kết nối tới máy chủ';
      case DioExceptionType.badResponse:
        return 'Đã xảy ra lỗi';
      case DioExceptionType.unknown:
      default:
        return 'Lỗi không xác định';
    }
  }
}
