import 'package:klinikku/features/booking/models/appointment_slot_item.dart';
import 'package:klinikku/features/booking/models/doctor_model.dart';
import 'package:klinikku/features/booking/models/region_model.dart';

class BookingConfirmationModel {
  final DoctorModel doctor;
  final RegionModel region;
  final AppointmentSlotItem appointment;

  const BookingConfirmationModel({
    required this.doctor,
    required this.region,
    required this.appointment,
  });
}
