import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klinikku/cores/bases/base_form_notifier.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/cores/models/selection_input_model.dart';
import 'package:klinikku/features/booking/models/appointment_day_item.dart';
import 'package:klinikku/features/booking/models/appointment_slot_item.dart';
import 'package:klinikku/features/booking/models/doctor_model.dart';
import 'package:klinikku/features/booking/models/region_model.dart';
import 'package:klinikku/features/booking/models/select_appointment_form_model.dart';
import 'package:klinikku/features/booking/services/select_appointment_services.dart';

final selectAppointmentVm = ChangeNotifierProvider.autoDispose(
  SelectAppointmentVM.new,
);

class SelectAppointmentVM extends BaseFormNotifier<SelectAppointmentFormModel>
    with ToastMixin {
  @override
  late SelectAppointmentFormModel form;

  List<RegionModel> regions = [];
  List<DoctorModel> doctors = [];
  late List<AppointmentDayItem> availableDays;
  List<AppointmentSlotItem> slots = [];

  int selectedDayIndex = 1;

  final SelectAppointmentServices _service = SelectAppointmentServices();

  SelectAppointmentVM(super.ref);

  @override
  FutureOr<void> init() async {
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

    form = SelectAppointmentFormModel(
      region: SelectionInputModel<RegionModel>(),
      doctor: SelectionInputModel<DoctorModel>(),
      date: SelectionInputModel<DateTime>(),
    );

    await getRegions();
  }

  String get selectedDateText => availableDays[selectedDayIndex].fullLabel;

  void selectDay(int index) async {
    selectedDayIndex = index;
    form.date.selectedValue = availableDays[index].date;

    if (form.region.selectedValue != null &&
        form.doctor.selectedValue != null &&
        form.date.selectedValue != null) {
      await getAppointments();
    }
    notifyListeners();
  }

  void onRegionChanged(String id) async {
    await getDoctors(id);
  }

  void onDoctorChanged(DoctorModel value) {
    notifyListeners();
  }

  void onSlotTap(AppointmentSlotItem slot) {}

  getRegions() async {
    final response = await _service.getRegions();

    if (response is DioException) {
      String errorMsg =
          response.response == null
              ? "Internal server error."
              : response.response!.data['error']['message'];
      showErrorToast(errorMsg);
      return;
    }

    final data = response.data['regions'];

    regions =
        (data as List<dynamic>)
            .map((item) => RegionModel.fromResponseBody(item))
            .toList();

    notifyListeners();
  }

  getDoctors(String id) async {
    isLoading = true;
    final response = await _service.getDoctors(id);
    isLoading = false;

    if (response is DioException) {
      String errorMsg =
          response.response == null
              ? "Internal server error."
              : response.response!.data['error']['message'];
      showErrorToast(errorMsg);
      return;
    }

    final data = response.data['doctors'];

    doctors =
        (data as List<dynamic>)
            .map((item) => DoctorModel.fromResponseBody(item))
            .toList();

    notifyListeners();
  }

  getAppointments() async {
    if (form.region.selectedValue == null ||
        form.doctor.selectedValue == null ||
        form.date.selectedValue == null) {
      return;
    }

    isLoading = true;
    final response = await _service.getAppointments(
      form.region.selectedValue!.id,
      form.doctor.selectedValue!.id,
      form.date.selectedValue!,
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

    final data = response.data['appointments'];

    slots =
        (data as List<dynamic>)
            .map((item) => AppointmentSlotItem.fromResponseBody(item))
            .toList();

    notifyListeners();
  }
}
