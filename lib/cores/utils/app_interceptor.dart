import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppInterceptor extends Interceptor {
  final Dio dio;

  AppInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('==== ERROR INTERCEPTOR START ====');
      print('$err');
      print('uri ${err.requestOptions.uri}');
      print('path ${err.requestOptions.path}');
      print('params ${err.requestOptions.queryParameters}');
      print('message ${err.message}');
      print('response ${err.response}');
      print('error status code ${err.response?.statusCode}');
      print('==== ERROR INTERCEPTOR END ====');
    }

    handler.next(err);
  }
}
