import 'package:base/data/repository/source/remote/api/auth_api.dart';
import 'package:base/data/repository/source/remote/api/error/api_error_mapper.dart';
import 'package:base/data/repository/source/remote/api/none_auth_api.dart';

extension AuthApiExt on AuthApi {
  Future<R> execute<R>(Future<R> Function(AuthApi api) block) async {
    try {
      return await block.call(this);
    } catch (e) {
      throw ApiErrorMapper.instance.map(e);
    }
  }
}

extension NoneAuthApiExt on NoneAuthApi {
  Future<R> execute<R>(Future<R> Function(NoneAuthApi api) block) async {
    try {
      return await block.call(this);
    } catch (e) {
      throw ApiErrorMapper.instance.map(e);
    }
  }
}
