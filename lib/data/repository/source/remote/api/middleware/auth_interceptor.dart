import 'package:base/config/env.dart';
import 'package:base/data/repository/source/remote/api/helper/api_config.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers[ApiConfig.authorization] = "Bearer ${Env.apiKey}";
    options.headers[ApiConfig.contentType] = "application/json";
    handler.next(options);
  }
}
