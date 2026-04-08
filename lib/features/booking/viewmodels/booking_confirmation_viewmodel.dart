import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klinikku/cores/bases/base_form_notifier.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/cores/models/text_input_model.dart';
import 'package:klinikku/features/booking/models/booking_confirmation_form_model.dart';

final bookingConfirmationVm =
    ChangeNotifierProvider.autoDispose<BookingConfirmationVM>(
      BookingConfirmationVM.new,
    );

class BookingConfirmationVM
    extends BaseFormNotifier<BookingConfirmationFormModel>
    with ToastMixin {
  @override
  late BookingConfirmationFormModel form;

  BookingConfirmationVM(super.ref);

  @override
  FutureOr<void> init() {
    form = BookingConfirmationFormModel(complaint: TextInputModel());
  }

  Future<void> confirmBooking() async {
    if (!validate()) return;
    showSuccessToast('Booking berhasil dikonfirmasi');
  }
}
