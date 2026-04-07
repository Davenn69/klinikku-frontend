import 'package:dio/dio.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/cores/utils/app_interceptor.dart';
import '../configs/flavor_config.dart';

const Duration _defaultTimeout = Duration(minutes: 1); //60 seconds

class BaseService with ToastMixin {
  final Dio _dio = Dio();

  BaseService() {
    _dio.interceptors.add(AppInterceptor(_dio));
  }

  get({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    String? tempToken,
  }) async {
    final Response<dynamic> response = await _dio.get(
      '${FlavorConfig.instance?.values.apiUrl}$url',
      queryParameters: params,
      options: Options(
        headers: {
          'Authorization':
              tempToken ?? 'Bearer ${FlavorConfig.instance?.values.token}',
          ...?headers,
        },
        receiveTimeout: _defaultTimeout,
        sendTimeout: _defaultTimeout,
      ),
    );
    return response;
  }

  post({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    dynamic imageData,
    bool isContentTypeFormData = false,
    String? tempToken,
  }) async {
    final Response<dynamic> response = await _dio.post(
      '${FlavorConfig.instance?.values.apiUrl}$url',
      options: Options(
        headers: {
          'Authorization':
              tempToken ?? 'Bearer ${FlavorConfig.instance?.values.token}',
          ...?headers,
        },
        receiveTimeout: _defaultTimeout,
        sendTimeout: _defaultTimeout,
        contentType: isContentTypeFormData ? 'multipart/form-data' : null,
      ),
      data: isContentTypeFormData ? imageData : data,
    );
    return response;
  }

  put({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  }) async {
    final Response<dynamic> response = await _dio.put(
      '${FlavorConfig.instance?.values.apiUrl}$url',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${FlavorConfig.instance?.values.token}',
          ...?headers,
        },
        receiveTimeout: _defaultTimeout,
        sendTimeout: _defaultTimeout,
      ),
      data: data,
    );
    return response;
  }

  delete({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  }) async {
    final Response<dynamic> response = await _dio.delete(
      '${FlavorConfig.instance?.values.apiUrl}$url',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${FlavorConfig.instance?.values.token}',
          ...?headers,
        },
        receiveTimeout: _defaultTimeout,
        sendTimeout: _defaultTimeout,
      ),
      data: data,
    );
    return response;
  }
}
