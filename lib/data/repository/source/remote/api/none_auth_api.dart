import 'package:base/data/model/base_response.dart';
import 'package:base/data/model/province_dto.dart';
import 'package:base/data/model/request_body/login_request.dart';
import 'package:base/data/model/request_body/verify_otp_request.dart';
import 'package:base/data/model/skill_dto.dart';
import 'package:base/data/model/user_data.dart';
import 'package:base/data/model/verify_otp_data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'none_auth_api.g.dart';

@RestApi()
abstract class NoneAuthApi {
  factory NoneAuthApi(Dio dio) = _NoneAuthApi;

  @POST('/auth/user/login')
  Future<BaseResponse<UserData>> login(@Body() LoginRequest request);

  @POST('/auth/register')
  Future<BaseResponse<UserData>> register(@Body() FormData formData);

  @POST('/auth/verify-opt')
  Future<BaseResponse<VerifyOtpData>> verifyOtp(
    @Body() VerifyOtpRequest request,
  );

  @GET('/master/skills')
  Future<SkillsResponseDto> getSkills();

  @GET('/master/provinces')
  Future<ProvincesResponseDto> getProvinces();
}
