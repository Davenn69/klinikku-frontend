import 'package:dio/dio.dart';
import 'package:klinikku/cores/bases/base_services.dart';

class SelectAppointmentServices extends BaseService {
  getRegions() async {
    try {
      final response = await get(url: '/regions');
      print(response);
      return response;
    } on DioException catch (e) {
      print('error get regions $e');
      return e;
    }
  }

  getDoctors(String regionId) async {
    try {
      final response = await get(
        url: '/doctors',
        params: {"region_id": regionId},
      );
      print(response);
      return response;
    } on DioException catch (e) {
      print('error get doctors $e');
      return e;
    }
  }

  getAppointments(String regionId, String doctorId, DateTime date) async {
    try {
      final response = await get(
        url: '/appointment-slots',
        params: {"region_id": regionId, "doctor_id": doctorId, "date": date},
      );
      print(response);
      return response;
    } on DioException catch (e) {
      print('error get appointments $e');
      return e;
    }
  }
}
