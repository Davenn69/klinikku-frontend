import 'package:dio/dio.dart';
import 'package:klinikku/cores/bases/base_services.dart';

class UpdateAppointmentServices extends BaseService {
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
