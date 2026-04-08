import 'package:flutter/material.dart';
import 'package:klinikku/cores/constants/colors.dart';

enum BookingListStatus { booked, confirmed, selesai, batal }

class BookingListItemModel {
  final String bookingCode;
  final String doctorName;
  final String specialization;
  final String regionName;
  final BookingListStatus status;
  final String dateTimeLabel;

  const BookingListItemModel({
    required this.bookingCode,
    required this.doctorName,
    required this.specialization,
    required this.regionName,
    required this.status,
    required this.dateTimeLabel,
  });

  String get statusLabel {
    switch (status) {
      case BookingListStatus.booked:
        return 'BOOKED';
      case BookingListStatus.confirmed:
        return 'CONFIRMED';
      case BookingListStatus.selesai:
        return 'SELESAI';
      case BookingListStatus.batal:
        return 'BATAL';
    }
  }

  Color get statusBackgroundColor {
    switch (status) {
      case BookingListStatus.booked:
        return const Color(0xFFE3F1EE);
      case BookingListStatus.confirmed:
        return const Color(0xFFE1EAFB);
      case BookingListStatus.selesai:
        return const Color(0xFFE1F2E8);
      case BookingListStatus.batal:
        return const Color(0xFFF8E5E1);
    }
  }

  Color get statusTextColor {
    switch (status) {
      case BookingListStatus.booked:
        return AppColors.primary;
      case BookingListStatus.confirmed:
        return const Color(0xFF376BC4);
      case BookingListStatus.selesai:
        return const Color(0xFF459C66);
      case BookingListStatus.batal:
        return const Color(0xFFE78C7D);
    }
  }
}
