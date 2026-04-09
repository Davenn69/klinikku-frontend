import 'dart:ui';

import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/features/booking/models/appointment_slot_item.dart';
import 'package:klinikku/features/booking/models/doctor_model.dart';
import 'package:klinikku/features/booking/models/region_model.dart';

enum BookingListStatus { booked, confirmed, done, cancelled }

class BookingModel {
  final String id;
  final String bookingCode;
  final DoctorModel doctor;
  final RegionModel region;
  final AppointmentSlotItem appointmentSlot;
  final String? complaint;
  final BookingListStatus status;
  final String? cancelledReason;

  const BookingModel({
    required this.id,
    required this.bookingCode,
    required this.doctor,
    required this.region,
    required this.appointmentSlot,
    required this.complaint,
    required this.status,
    required this.cancelledReason,
  });

  factory BookingModel.fromResponseBody(Map<String, dynamic> json) =>
      BookingModel(
        id: json['id'],
        bookingCode: json['bookingCode'],
        doctor: DoctorModel.fromResponseBody(json['doctor']),
        region: RegionModel.fromResponseBody(json['region']),
        appointmentSlot: AppointmentSlotItem.fromResponseBody(
          json['appointment'],
        ),
        complaint: json['complaint'],
        status: getStatus(json['status']),
        cancelledReason: json['cancelledReason'],
      );

  String get statusLabel {
    switch (status) {
      case BookingListStatus.booked:
        return 'BOOKED';
      case BookingListStatus.confirmed:
        return 'CONFIRMED';
      case BookingListStatus.done:
        return 'SELESAI';
      case BookingListStatus.cancelled:
        return 'BATAL';
    }
  }

  Color get statusBackgroundColor {
    switch (status) {
      case BookingListStatus.booked:
        return const Color(0xFFE3F1EE);
      case BookingListStatus.confirmed:
        return const Color(0xFFE1EAFB);
      case BookingListStatus.done:
        return const Color(0xFFE1F2E8);
      case BookingListStatus.cancelled:
        return const Color(0xFFF8E5E1);
    }
  }

  Color get statusTextColor {
    switch (status) {
      case BookingListStatus.booked:
        return AppColors.primary;
      case BookingListStatus.confirmed:
        return const Color(0xFF376BC4);
      case BookingListStatus.done:
        return const Color(0xFF459C66);
      case BookingListStatus.cancelled:
        return const Color(0xFFE78C7D);
    }
  }

  static BookingListStatus getStatus(String status) {
    switch (status) {
      case "BOOKED":
        return BookingListStatus.booked;
      case "CONFIRMED":
        return BookingListStatus.confirmed;
      case "DONE":
        return BookingListStatus.done;
      case "CANCELLED":
        return BookingListStatus.cancelled;
      default:
        return BookingListStatus.booked;
    }
  }
}
