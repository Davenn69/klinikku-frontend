import 'package:klinikku/cores/models/selection_input_model.dart';

class SelectAppointmentFormModel {
  final SelectionInputModel<String> region;
  final SelectionInputModel<String> doctor;
  final SelectionInputModel<DateTime> date;

  const SelectAppointmentFormModel({
    required this.region,
    required this.doctor,
    required this.date,
  });
}
