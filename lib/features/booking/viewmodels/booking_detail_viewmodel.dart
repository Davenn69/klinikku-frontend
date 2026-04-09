import 'dart:async';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/bases/base_notifier.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/features/booking/models/booking_model.dart';
import 'package:klinikku/features/booking/services/booking_detail_services.dart';
import 'package:klinikku/features/booking/viewmodels/booking_list_viewmodel.dart';

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

  deleteBooking() async {
    final response = await _service.deleteBooking(bookingId);

    if (response is DioException) {
      String errorMsg =
          response.response == null
              ? "Internal server error."
              : response.response!.data['error']['message'];
      showErrorToast(errorMsg);
      return;
    }

    showSuccessToast('This appointment has been cancelled');

    ref.invalidate(bookingListVM);
    ctx.pop();
  }
}
