import 'package:base/domain/model/skill.dart';
import 'package:base/domain/repository/master_repository.dart';

class GetSkillsUseCase {
  final MasterRepository _repository;

  const GetSkillsUseCase(this._repository);

  Future<List<Skill>> execute() async {
    return await _repository.getSkills();
  }
}
