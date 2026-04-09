import 'package:dio/dio.dart';
import 'package:klinikku/cores/bases/base_services.dart';

class SplashServices extends BaseService {
  refresh(String refreshToken) async {
    try {
      final response = await post(
        url: '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      print(response);
      return response;
    } on DioException catch (e) {
      print('error refresh token $e');
      return e;
    }
  }
}
