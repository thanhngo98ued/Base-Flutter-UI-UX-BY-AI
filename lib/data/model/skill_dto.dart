import 'package:base/domain/model/skill.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skill_dto.g.dart';

@JsonSerializable()
class SkillDto {
  @JsonKey(name: 'skillId')
  final int skillId;
  
  @JsonKey(name: 'skillName')
  final String skillName;
  
  @JsonKey(name: 'skillIcon')
  final String skillIcon;
  
  @JsonKey(name: 'createdAt')
  final String createdAt;
  
  @JsonKey(name: 'modifiedAt')
  final String modifiedAt;
  
  @JsonKey(name: 'deletedAt')
  final String? deletedAt;

  const SkillDto({
    required this.skillId,
    required this.skillName,
    required this.skillIcon,
    required this.createdAt,
    required this.modifiedAt,
    this.deletedAt,
  });

  factory SkillDto.fromJson(Map<String, dynamic> json) => _$SkillDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SkillDtoToJson(this);

  Skill toDomain() {
    return Skill(
      skillId: skillId,
      skillName: skillName,
      skillIcon: skillIcon,
      createdAt: DateTime.parse(createdAt),
      modifiedAt: DateTime.parse(modifiedAt),
      deletedAt: deletedAt != null ? DateTime.parse(deletedAt!) : null,
    );
  }
}

@JsonSerializable()
class SkillsResponseDto {
  @JsonKey(name: 'statusCode')
  final int statusCode;
  
  @JsonKey(name: 'message')
  final String message;
  
  @JsonKey(name: 'data')
  final SkillsDataDto data;

  const SkillsResponseDto({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SkillsResponseDto.fromJson(Map<String, dynamic> json) => 
      _$SkillsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SkillsResponseDtoToJson(this);
}

@JsonSerializable()
class SkillsDataDto {
  @JsonKey(name: 'skills')
  final List<SkillDto> skills;

  const SkillsDataDto({
    required this.skills,
  });

  factory SkillsDataDto.fromJson(Map<String, dynamic> json) => 
      _$SkillsDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SkillsDataDtoToJson(this);

  List<Skill> toDomainList() {
    return skills.map((dto) => dto.toDomain()).toList();
  }
}
