import 'package:base/domain/error/error_entity.dart';

abstract class ErrorMapper {
  ErrorEntity map(Object? exception);
}
