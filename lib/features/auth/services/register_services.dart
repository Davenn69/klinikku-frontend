import 'package:dio/dio.dart';
import 'package:klinikku/cores/bases/base_services.dart';

class RegisterServices extends BaseService {
  register(String name, String email, String password) async {
    try {
      final response = await post(
        url: '/auth/register',
        data: {"email": email, "password": password, "name": name},
      );
      print(response);
      return response;
    } on DioException catch (e) {
      print('register error $e');
      return e;
    }
  }
}
