import 'package:base/shared/utils/common_utils.dart';
import 'package:dio/dio.dart';

class ConnectivityInterceptor extends Interceptor {
  const ConnectivityInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!await isNetworkAvailable) {
      return handler.reject(DioException(requestOptions: options, type: DioExceptionType.connectionError));
    }

    return super.onRequest(options, handler);
  }
}
