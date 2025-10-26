import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class VerifyOtpRequest {
  VerifyOtpRequest({
    required this.code,
    required this.phone,
  });

  @JsonKey(name: 'code')
  final String code;

  @JsonKey(name: 'phone')
  final String phone;

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}

