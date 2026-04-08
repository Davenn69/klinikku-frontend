import 'package:dio/dio.dart';
import 'package:klinikku/cores/bases/base_services.dart';

class BookingListServices extends BaseService {
  getBookingList() async {
    try {
      final response = await get(url: '/encounters');
      print(response);
      return response;
    } on DioException catch (e) {
      print('error get booking list $e');
      return e;
    }
  }
}
