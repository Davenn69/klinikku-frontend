import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klinikku/cores/bases/base_form_notifier.dart';
import 'package:klinikku/cores/models/selection_input_model.dart';
import 'package:klinikku/features/booking/models/select_appointment_form_model.dart';

final selectAppointmentVm = ChangeNotifierProvider.autoDispose(
  SelectAppointmentVM.new,
);

class SelectAppointmentVM extends BaseFormNotifier<SelectAppointmentFormModel> {
  @override
  late SelectAppointmentFormModel form;

  SelectAppointmentVM(super.ref);

  @override
  FutureOr<void> init() {
    form = SelectAppointmentFormModel(
      region: SelectionInputModel(),
      doctor: SelectionInputModel(),
      date: SelectionInputModel(),
    );
  }
}
