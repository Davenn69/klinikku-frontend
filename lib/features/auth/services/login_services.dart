import 'package:dio/dio.dart';
import 'package:klinikku/cores/bases/base_services.dart';

class LoginServices extends BaseService {
  login(String email, String password) async {
    try {
      final response = await post(
        url: '/auth/login',
        data: {"email": email, "password": password},
      );
      print(response);
      return response;
    } on DioException catch (e) {
      print('login error $e');
      return e;
    }
  }
}
