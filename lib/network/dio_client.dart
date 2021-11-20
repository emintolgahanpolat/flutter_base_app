import 'package:dio/dio.dart';
import 'package:mvvm/network/error_interceptor.dart';
import 'package:mvvm/network/logging_interceptor.dart';

import 'api_service.dart';

class DioClient {
  static Dio? _dio;
  static Dio get instance {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
          baseUrl: ApiService.baseUrl,
          queryParameters: {},
          headers: {
            Headers.contentTypeHeader: "application/json;charset=UTF-8",
            "Authorization": ApiService.apiKey
          }));

      _dio?.interceptors.add(LoggingInterceptor());
      _dio?.interceptors.add(ErrorInterceptor());
      // _dio?.interceptors.add(LogInterceptor());

      //_dio?.options.connectTimeout = 60000;
      //_dio?.options.receiveTimeout = 60000;

    }
    return _dio!;
  }

  static void close({bool force = false}) {
    _dio?.close(force: force);
  }
}
