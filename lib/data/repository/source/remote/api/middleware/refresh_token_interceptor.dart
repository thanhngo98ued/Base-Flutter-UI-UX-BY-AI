import 'dart:collection';
import 'dart:io';

import 'package:base/data/repository/source/local/user_local_data_source.dart';
import 'package:dio/dio.dart';

class RefreshTokenInterceptor extends InterceptorsWrapper {
  RefreshTokenInterceptor(
    this._userLocalDataSource,
    this._currentDio,
  );

  final UserLocalDataSource _userLocalDataSource;
  final Dio _currentDio;

  final _queue = Queue<({RequestOptions options, ErrorInterceptorHandler handler})>();
  var _isRefreshing = false;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      final options = err.response!.requestOptions;
      _onAccessTokenExpired(options: options, handler: handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _onAccessTokenExpired({
    required RequestOptions options,
    required ErrorInterceptorHandler handler,
  }) async {
    _queue.addLast((options: options, handler: handler));
    if (!_isRefreshing) {
      _isRefreshing = true;
      try {
        final newAccessToken = await _refreshToken();
        await _onRefreshTokenSuccess(newAccessToken);
      } catch (e) {
        _onRefreshTokenError(e);
      } finally {
        _isRefreshing = false;
        _queue.clear();
      }
    }
  }

  Future<String> _refreshToken() async {
    _isRefreshing = true;
    // Call refresh token
    final newAccessToken = await _userLocalDataSource.getAccessToken() ?? "";
    return newAccessToken;
  }

  Future<void> _onRefreshTokenSuccess(String newToken) async {
    await Future.wait(_queue.map(
      (requestInfo) => _requestWithNewToken(
        options: requestInfo.options,
        handler: requestInfo.handler,
        newAccessToken: newToken,
      ),
    ));
  }

  void _onRefreshTokenError(Object? error) {
    for (var element in _queue) {
      final options = element.options;
      final handler = element.handler;
      handler.next(DioException(requestOptions: options, error: error));
    }
  }

  Future<void> _requestWithNewToken({
    required RequestOptions options,
    required ErrorInterceptorHandler handler,
    required String newAccessToken,
  }) async {
    _putAccessToken(headers: options.headers, accessToken: newAccessToken);

    try {
      final response = await _currentDio.fetch(options);
      handler.resolve(response);
    } catch (e) {
      handler.next(DioException(requestOptions: options, error: e));
    }
  }

  void _putAccessToken({
    required Map<String, dynamic> headers,
    required String accessToken,
  }) {
    // headers[ApiConfig.xAuthorization] = accessToken;
  }
}
