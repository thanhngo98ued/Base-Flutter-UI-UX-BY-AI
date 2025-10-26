import 'package:base/data/model/province_dto.dart';
import 'package:base/data/model/skill_dto.dart';
import 'package:base/data/repository/source/remote/api/none_auth_api.dart';

abstract class MasterDataSource {
  Future<SkillsResponseDto> getSkills();
  Future<ProvincesResponseDto> getProvinces();
}

class MasterDataSourceImpl implements MasterDataSource {
  final NoneAuthApi _api;

  const MasterDataSourceImpl(this._api);

  @override
  Future<SkillsResponseDto> getSkills() async {
    return await _api.getSkills();
  }

  @override
  Future<ProvincesResponseDto> getProvinces() async {
    return await _api.getProvinces();
  }
}
