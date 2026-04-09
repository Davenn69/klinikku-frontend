import 'dart:async';

import 'package:dio/dio.dart';
import 'package:klinikku/cores/bases/base_notifier.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/features/booking/models/booking_model.dart';
import 'package:klinikku/features/booking/services/booking_detail_services.dart';

class BookingDetailVM extends BaseNotifier with ToastMixin {
  final String bookingId;
  late BookingModel detail;

  final BookingDetailServices _service = BookingDetailServices();

  BookingDetailVM(super.ref, {required this.bookingId});

  @override
  FutureOr<void> init() async {
    await getBookingDetail();
  }

  getBookingDetail() async {
    final response = await _service.getDetail(bookingId);

    if (response is DioException) {
      String errorMsg =
          response.response == null
              ? "Internal server error."
              : response.response!.data['error']['message'];
      showErrorToast(errorMsg);
      return;
    }

    final data = response.data['encounter'];

    detail = BookingModel.fromResponseBody(data);
  }
}
