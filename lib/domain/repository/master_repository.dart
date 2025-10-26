import 'package:base/domain/model/province.dart';
import 'package:base/domain/model/skill.dart';

abstract class MasterRepository {
  Future<List<Skill>> getSkills();
  Future<List<Province>> getProvinces();
}
