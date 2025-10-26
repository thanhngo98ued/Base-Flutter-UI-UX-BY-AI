import 'package:json_annotation/json_annotation.dart';

part 'api_error_response.g.dart';

@JsonSerializable()
class ApiErrorResponse {
  ApiErrorResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  final int statusCode;
  final dynamic
  message; // Can be String or Map<String, String> for validation errors
  final dynamic data;

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorResponseToJson(this);

  String get errorMessage {
    if (message is String) {
      return message as String;
    } else if (message is Map) {
      // For validation errors (422), combine all field errors
      final errorMap = message as Map<String, dynamic>;
      return errorMap.values.join(', ');
    }
    return 'Unknown error occurred';
  }
}
