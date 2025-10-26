import 'package:base/data/model/base_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData extends BaseData {
  UserData({
    required this.id,
    required this.name,
    required this.phone,
    this.avatar,
    this.address,
    this.rating,
    this.jobsCompleted,
    this.skills,
    this.isOnline,
    this.location,
    this.accessToken,
    this.refreshToken,
    this.phoneNumber,
    this.userId,
    this.verifyOPT,
    this.userName,
    this.roleId,
    this.yearExp,
    this.passportFront,
    this.passportBack,
    this.createdAt,
    this.modifiedAt,
    this.deletedAt,
  });

  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "avatar")
  final String? avatar;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "rating")
  final double? rating;
  @JsonKey(name: "jobsCompleted")
  final int? jobsCompleted;
  @JsonKey(name: "skills")
  final List<String>? skills;
  @JsonKey(name: "isOnline")
  final bool? isOnline;
  @JsonKey(name: "location")
  final LocationData? location;

  @JsonKey(name: "accessToken")
  final String? accessToken;
  @JsonKey(name: "refreshToken")
  final String? refreshToken;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "verifyOPT")
  final int? verifyOPT;

  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "roleId")
  final int? roleId;
  @JsonKey(name: "yearExp")
  final int? yearExp;
  @JsonKey(name: "passportFront")
  final String? passportFront;
  @JsonKey(name: "passportBack")
  final String? passportBack;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "modifiedAt")
  final String? modifiedAt;
  @JsonKey(name: "deletedAt")
  final String? deletedAt;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class LocationData {
  LocationData({required this.lat, required this.lng});

  @JsonKey(name: "lat")
  final double lat;
  @JsonKey(name: "lng")
  final double lng;

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDataToJson(this);
}
