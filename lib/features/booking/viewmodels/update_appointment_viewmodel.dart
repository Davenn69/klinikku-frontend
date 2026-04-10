import 'dart:async';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/bases/base_form_notifier.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/cores/models/selection_input_model.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/features/booking/models/appointment_day_item.dart';
import 'package:klinikku/features/booking/models/appointment_slot_item.dart';
import 'package:klinikku/features/booking/models/doctor_model.dart';
import 'package:klinikku/features/booking/models/region_model.dart';
import 'package:klinikku/features/booking/models/update_appointment_form_model.dart';
import 'package:klinikku/features/booking/services/update_appointment_services.dart';

class UpdateAppointmentVM extends BaseFormNotifier<UpdateAppointmentFormModel>
    with ToastMixin {
  RegionModel region;
  DoctorModel doctor;
  @override
  late UpdateAppointmentFormModel form;

  late List<AppointmentDayItem> availableDays;

  int selectedDayIndex = 0;
  List<AppointmentSlotItem> slots = [];

  final UpdateAppointmentServices _service = UpdateAppointmentServices();

  UpdateAppointmentVM(super.ref, {required this.region, required this.doctor});

  @override
  FutureOr<void> init() {
    availableDays = _generateAvailableDays();
    form = UpdateAppointmentFormModel(
      region: SelectionInputModel(),
      doctor: SelectionInputModel(),
      date: SelectionInputModel(),
    );

    form.region.selectedValue = region;
    form.doctor.selectedValue = doctor;
    form.date.selectedValue = DateTime.now();

    getAppointments();
  }

  String get selectedDateText =>
      availableDays.isEmpty ? '' : availableDays[selectedDayIndex].fullLabel;

  List<AppointmentDayItem> _generateAvailableDays() {
    final today = DateTime.now();
    final startDate = DateTime(today.year, today.month, today.day);

    return List.generate(7, (index) {
      final date = startDate.add(Duration(days: index));
      final dayLabel = _weekdayLabel(date.weekday);
      return AppointmentDayItem(
        dayNumber: '${date.day}',
        dayLabel: dayLabel,
        fullLabel: '$dayLabel, ${date.day} ${_monthLabel(date.month)}',
        date: date,
      );
    });
  }

  String _weekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Sen';
      case DateTime.tuesday:
        return 'Sel';
      case DateTime.wednesday:
        return 'Rab';
      case DateTime.thursday:
        return 'Kam';
      case DateTime.friday:
        return 'Jum';
      case DateTime.saturday:
        return 'Sab';
      case DateTime.sunday:
        return 'Min';
      default:
        return '';
    }
  }

  String _monthLabel(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'Mei';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Agu';
      case 9:
        return 'Sep';
      case 10:
        return 'Okt';
      case 11:
        return 'Nov';
      case 12:
        return 'Des';
      default:
        return '';
    }
  }

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

  void onSlotTap(AppointmentSlotItem slot, String bookingId) {
    if (form.doctor.selectedValue == null ||
        form.region.selectedValue == null) {
      return;
    }
    ctx.pushNamed(
      RouterRoutes.bookingConfirmation.name,
      extra: {
        'doctor': form.doctor.selectedValue,
        'region': form.region.selectedValue,
        'appointment': slot,
        'isUpdate': true,
        'bookingId': bookingId,
      },
    );
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
  }
}
