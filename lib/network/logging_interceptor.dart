import 'package:dio/dio.dart';
import 'package:mvvm/util/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var timestamp = "${DateTime.now().millisecondsSinceEpoch}";
    options.headers["timestamp"] = timestamp;

    Log.i("""--> 
    START REQUEST
    ${options.method} ${options.baseUrl}${options.path} 
    Content type: ${options.contentType}
    QueryParameters : ${options.queryParameters}
    Headers : ${options.headers}
    Data : ${options.data}
    <-- END REQUEST""", tag: timestamp);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.d("""--> 
    START RESPONSE
    ${response.requestOptions.method} - ${response.requestOptions.baseUrl}${response.requestOptions.path} - ${response.statusCode}
    ${response.data.toString().trim()}
    <-- END RESPONSE""",
        tag: response.requestOptions.headers["timestamp"].toString());

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.e("""--> 
    START ERROR
    ${err.requestOptions.method} - ${err.requestOptions.baseUrl}${err.requestOptions.path} - ${err.response?.statusCode}
    ${err.requestOptions.headers}
    ${err.requestOptions.data}
    ${err.response?.data.toString().trim()}
    <-- END ERROR""", tag: err.requestOptions.headers["timestamp"].toString());

    return super.onError(err, handler);
  }
}

extension DioErrorTypeExtention on DioErrorType {
  String message(int? statusCode) {
    switch (this) {
      case DioErrorType.response:
        return statusCode.toString();
      default:
        String text = toString().split(".").last;
        RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
        return text
            .replaceAllMapped(exp, (Match m) => (" " + m.group(0).toString()))
            .toLowerCase();
    }
  }
}
