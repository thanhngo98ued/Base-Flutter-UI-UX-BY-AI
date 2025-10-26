import 'package:base/data/model/base_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_data.g.dart';

@JsonSerializable()
class VerifyOtpData extends BaseData {
  VerifyOtpData({
    required this.verified,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpDataFromJson(json);

  @JsonKey(name: 'verified')
  final bool verified;

  Map<String, dynamic> toJson() => _$VerifyOtpDataToJson(this);
}

