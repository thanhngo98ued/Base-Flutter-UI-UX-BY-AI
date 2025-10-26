import 'package:base/domain/model/province.dart';
import 'package:json_annotation/json_annotation.dart';

part 'province_dto.g.dart';

@JsonSerializable()
class ProvinceDto {
  @JsonKey(name: 'provinceId')
  final int provinceId;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'modifiedAt')
  final String modifiedAt;

  @JsonKey(name: 'deletedAt')
  final String? deletedAt;

  const ProvinceDto({
    required this.provinceId,
    required this.name,
    required this.createdAt,
    required this.modifiedAt,
    this.deletedAt,
  });

  factory ProvinceDto.fromJson(Map<String, dynamic> json) =>
      _$ProvinceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceDtoToJson(this);

  Province toDomain() {
    return Province(
      provinceId: provinceId,
      name: name,
      createdAt: DateTime.parse(createdAt),
      modifiedAt: DateTime.parse(modifiedAt),
      deletedAt: deletedAt != null ? DateTime.parse(deletedAt!) : null,
    );
  }
}

@JsonSerializable()
class ProvincesResponseDto {
  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final ProvincesDataDto data;

  const ProvincesResponseDto({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ProvincesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProvincesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProvincesResponseDtoToJson(this);
}

@JsonSerializable()
class ProvincesDataDto {
  @JsonKey(name: 'provinces')
  final List<ProvinceDto> provinces;

  const ProvincesDataDto({required this.provinces});

  factory ProvincesDataDto.fromJson(Map<String, dynamic> json) =>
      _$ProvincesDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProvincesDataDtoToJson(this);

  List<Province> toDomainList() {
    return provinces.map((dto) => dto.toDomain()).toList();
  }
}
