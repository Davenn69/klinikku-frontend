import 'package:dio/dio.dart';
import 'package:klinikku/cores/bases/base_services.dart';

class BookingConfirmationServices extends BaseService {
  createBooking({
    required String doctorId,
    required String regionId,
    required String complaint,
    required String appointmentId,
  }) async {
    try {
      final response = await post(
        url: '/encounters',
        data: {
          'doctor_id': doctorId,
          'region_id': regionId,
          'appointment_slot_id': appointmentId,
          'complaint': complaint,
        },
      );
      print(response);
      return response;
    } on DioException catch (e) {
      print('error create booking');
      return e;
    }
  }

  updateBooking({
    required String bookingId,
    required String complaint,
    required String appointmentId,
  }) async {
    try {
      final response = await put(
        url: '/encounters/$bookingId',
        data: {'appointment_id': appointmentId, 'complaint': complaint},
      );
      print(response);
      return response;
    } on DioException catch (e) {
      print('error create booking');
      return e;
    }
  }
}
