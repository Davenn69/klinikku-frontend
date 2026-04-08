import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klinikku/cores/bases/base_form_notifier.dart';
import 'package:klinikku/cores/models/selection_input_model.dart';
import 'package:klinikku/features/booking/models/appointment_day_item.dart';
import 'package:klinikku/features/booking/models/appointment_slot_item.dart';
import 'package:klinikku/features/booking/models/select_appointment_form_model.dart';

final selectAppointmentVm = ChangeNotifierProvider.autoDispose(
  SelectAppointmentVM.new,
);

class SelectAppointmentVM extends BaseFormNotifier<SelectAppointmentFormModel> {
  @override
  late SelectAppointmentFormModel form;

  late List<String> regions;
  late List<String> doctors;
  late List<AppointmentDayItem> availableDays;
  late List<AppointmentSlotItem> slots;

  int selectedDayIndex = 1;

  SelectAppointmentVM(super.ref);

  @override
  FutureOr<void> init() {
    regions = const ['Surabaya', 'Jakarta', 'Bandung', 'Yogyakarta'];
    doctors = const [
      'dr. Andi Wijaya, Sp.PD',
      'dr. Sinta Rahma, Sp.A',
      'dr. Fajar Nugraha, Sp.OG',
    ];

    availableDays = [
      AppointmentDayItem(
        dayNumber: '6',
        dayLabel: 'Sen',
        fullLabel: 'Sen, 6 Apr',
        date: DateTime(2026, 4, 6),
      ),
      AppointmentDayItem(
        dayNumber: '7',
        dayLabel: 'Sel',
        fullLabel: 'Sel, 7 Apr',
        date: DateTime(2026, 4, 7),
      ),
      AppointmentDayItem(
        dayNumber: '8',
        dayLabel: 'Rab',
        fullLabel: 'Rab, 8 Apr',
        date: DateTime(2026, 4, 8),
      ),
      AppointmentDayItem(
        dayNumber: '9',
        dayLabel: 'Kam',
        fullLabel: 'Kam, 9 Apr',
        date: DateTime(2026, 4, 9),
      ),
      AppointmentDayItem(
        dayNumber: '10',
        dayLabel: 'Jum',
        fullLabel: 'Jum, 10 Apr',
        date: DateTime(2026, 4, 10),
      ),
    ];

    slots = const [
      AppointmentSlotItem(
        timeRange: '08:00 - 08:30',
        detail: '30 menit - Penyakit Dalam',
        isAvailable: true,
      ),
      AppointmentSlotItem(
        timeRange: '08:30 - 09:00',
        detail: '30 menit - Penyakit Dalam',
        isAvailable: true,
      ),
      AppointmentSlotItem(
        timeRange: '09:00 - 09:30',
        detail: '30 menit - Penyakit Dalam',
        isAvailable: true,
      ),
      AppointmentSlotItem(
        timeRange: '09:30 - 10:00',
        detail: '30 menit - Penyakit Dalam',
        isAvailable: false,
      ),
    ];

    form = SelectAppointmentFormModel(
      region: SelectionInputModel<String>()..selectedValue = regions.first,
      doctor: SelectionInputModel<String>()..selectedValue = doctors.first,
      date:
          SelectionInputModel<DateTime>()
            ..selectedValue = availableDays[1].date,
    );
  }

  String get selectedDateText => availableDays[selectedDayIndex].fullLabel;

  void selectDay(int index) {
    selectedDayIndex = index;
    form.date.selectedValue = availableDays[index].date;
    notifyListeners();
  }

  void onRegionChanged(String value) {
    form.region.selectedValue = value;
    notifyListeners();
  }

  void onDoctorChanged(String value) {
    form.doctor.selectedValue = value;
    notifyListeners();
  }

  void onSlotTap(AppointmentSlotItem slot) {}
}
