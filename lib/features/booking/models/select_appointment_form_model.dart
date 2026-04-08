import 'package:klinikku/cores/models/selection_input_model.dart';
import 'package:klinikku/features/booking/models/doctor_model.dart';
import 'package:klinikku/features/booking/models/region_model.dart';

class SelectAppointmentFormModel {
  final SelectionInputModel<RegionModel> region;
  final SelectionInputModel<DoctorModel> doctor;
  final SelectionInputModel<DateTime> date;

  const SelectAppointmentFormModel({
    required this.region,
    required this.doctor,
    required this.date,
  });
}
