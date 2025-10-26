import 'package:base/data/model/base_response.dart';
import 'package:base/data/model/request_body/login_request.dart';
import 'package:base/data/model/request_body/verify_otp_request.dart';
import 'package:base/data/model/user_data.dart';
import 'package:base/data/model/verify_otp_data.dart';
import 'package:base/data/repository/source/remote/api/none_auth_api.dart';
import 'package:base/data/repository/source/remote/api/helper/api_ext.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._noneAuthApi);

  final NoneAuthApi _noneAuthApi;

  Future<BaseResponse<UserData>> login(String phone, String password) async {
    final request = LoginRequest(phone: phone, password: password);
    final response = await _noneAuthApi.execute((api) => api.login(request));
    return response;
  }

  Future<BaseResponse<UserData>> register({
    required String name,
    required String phone,
    required int roleId,
    required int provinceId,
    required String password,
    List<int>? skills,
    int? yearExp,
    MultipartFile? passportFront,
    MultipartFile? passportBack,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'roleId': roleId,
      'provinceId': provinceId,
      'password': password,
    });

    if (skills != null && skills.isNotEmpty) {
      for (var i = 0; i < skills.length; i++) {
        formData.fields.add(MapEntry('skills[$i]', skills[i].toString()));
      }
    }

    if (yearExp != null) {
      formData.fields.add(MapEntry('yearExp', yearExp.toString()));
    }

    if (passportFront != null) {
      formData.files.add(MapEntry('passportFront', passportFront));
    }

    if (passportBack != null) {
      formData.files.add(MapEntry('passportBack', passportBack));
    }

    final response = await _noneAuthApi.execute(
      (api) => api.register(formData),
    );
    return response;
  }

  Future<BaseResponse<VerifyOtpData>> verifyOtp(
    String code,
    String phone,
  ) async {
    final request = VerifyOtpRequest(code: code, phone: phone);
    final response = await _noneAuthApi.execute(
      (api) => api.verifyOtp(request),
    );
    return response;
  }
}
