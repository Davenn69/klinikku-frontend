import 'package:dio/dio.dart';
import 'package:klinikku/cores/bases/base_services.dart';

class BookingDetailServices extends BaseService {
  getDetail(String id) async {
    try {
      final response = await get(url: '/encounters/$id');
      print(response);
      return response;
    } on DioException catch (e) {
      print('error get booking detail $e');
      return e;
    }
  }

  deleteBooking(String id) async {
    try {
      final response = await delete(url: '/encounters/$id');
      print(response);
      return response;
    } on DioException catch (e) {
      print('error delete booking detail $e');
      return e;
    }
  }
}
