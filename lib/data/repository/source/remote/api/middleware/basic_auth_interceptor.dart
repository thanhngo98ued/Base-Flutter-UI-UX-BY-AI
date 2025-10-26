import 'package:dio/dio.dart';

class BasicAuthInterceptor extends Interceptor {
  BasicAuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers[ApiConfig.basicAuthorization] = _buildBasicAuthenticationHeader();
    handler.next(options);
  }
}
