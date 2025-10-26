import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final int skillId;
  final String skillName;
  final String skillIcon;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final DateTime? deletedAt;

  const Skill({
    required this.skillId,
    required this.skillName,
    required this.skillIcon,
    required this.createdAt,
    required this.modifiedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [
        skillId,
        skillName,
        skillIcon,
        createdAt,
        modifiedAt,
        deletedAt,
      ];

  @override
  bool get stringify => true;
}
