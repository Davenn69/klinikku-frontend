import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/bases/base_form_notifier.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/cores/models/text_input_model.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/features/booking/models/booking_confirmation_form_model.dart';
import 'package:klinikku/features/booking/services/booking_confirmation_services.dart';
import 'package:klinikku/features/booking/viewmodels/select_appointment_viewmodel.dart';

final bookingConfirmationVm =
    ChangeNotifierProvider.autoDispose<BookingConfirmationVM>(
      BookingConfirmationVM.new,
    );

class BookingConfirmationVM
    extends BaseFormNotifier<BookingConfirmationFormModel>
    with ToastMixin {
  @override
  late BookingConfirmationFormModel form;

  final BookingConfirmationServices _services = BookingConfirmationServices();

  BookingConfirmationVM(super.ref);

  @override
  FutureOr<void> init() {
    form = BookingConfirmationFormModel(complaint: TextInputModel());
  }

  Future<void> confirmBooking(
    String doctorId,
    String regionId,
    String appointmentId,
  ) async {
    if (!validate()) return;

    isLoading = true;
    final response = await _services.createBooking(
      doctorId: doctorId,
      regionId: regionId,
      complaint: form.complaint.text,
      appointmentId: appointmentId,
    );
    isLoading = false;
    if (response is DioException) {
      String errorMsg =
          response.response == null
              ? "Internal server error."
              : response.response!.data['error']['message'];
      showErrorToast(errorMsg);
      return;
    }

    ref.invalidate(selectAppointmentVm);
    final data = response.data['encounter'];
    ctx.pushReplacementNamed(
      RouterRoutes.bookingDetail.name,
      extra: {'id': data['id']},
    );
  }
}
