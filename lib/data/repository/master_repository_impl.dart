import 'package:base/data/repository/source/remote/master_data_source.dart';
import 'package:base/domain/model/province.dart';
import 'package:base/domain/model/skill.dart';
import 'package:base/domain/repository/master_repository.dart';

class MasterRepositoryImpl implements MasterRepository {
  final MasterDataSource _dataSource;

  const MasterRepositoryImpl(this._dataSource);

  @override
  Future<List<Skill>> getSkills() async {
    final response = await _dataSource.getSkills();
    return response.data.toDomainList();
  }

  @override
  Future<List<Province>> getProvinces() async {
    final response = await _dataSource.getProvinces();
    return response.data.toDomainList();
  }
}
