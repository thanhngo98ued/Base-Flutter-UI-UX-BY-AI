import 'package:base/domain/model/province.dart';
import 'package:base/domain/repository/master_repository.dart';

class GetProvincesUseCase {
  final MasterRepository _repository;

  const GetProvincesUseCase(this._repository);

  Future<List<Province>> execute() async {
    return await _repository.getProvinces();
  }
}
