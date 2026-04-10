import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/bases/base_form_notifier.dart';
import 'package:klinikku/cores/configs/flavor_config.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/cores/models/selection_input_model.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/utils/hive_helper.dart';
import 'package:klinikku/features/booking/models/booking_model.dart';
import 'package:klinikku/features/booking/models/region_model.dart';
import 'package:klinikku/features/dashboard/models/dashboard_form_model.dart';
import 'package:klinikku/features/dashboard/models/dashboard_nav_item.dart';
import 'package:klinikku/features/dashboard/models/dashboard_quick_action.dart';
import 'package:klinikku/features/dashboard/models/profile_model.dart';
import 'package:klinikku/features/dashboard/services/dashboard_services.dart';

final dashboardVM = ChangeNotifierProvider.autoDispose(DashboardVM.new);

class DashboardVM extends BaseFormNotifier<DashboardFormModel> with ToastMixin {
  @override
  late DashboardFormModel form;

  late List<DashboardQuickAction> quickActions;
  BookingModel? recentBooking;
  late List<DashboardNavItem> navigationItems;
  late ProfileModel profile;

  DateTime currentDateLabel = DateTime.now();
  int selectedNavIndex = 0;

  List<RegionModel> regions = [];
  List<BookingModel>? selectedBookings;

  final DashboardServices _services = DashboardServices();

  DashboardVM(super.ref);

  @override
  FutureOr<void> init() async {
    form = DashboardFormModel(region: SelectionInputModel());
    quickActions = [
      DashboardQuickAction(
        title: 'Buat Booking',
        icon: Icons.event_available_rounded,
        iconBackgroundColor: Color(0xFFE2F1EE),
        iconColor: Color(0xFF3A7F77),
        onTap: () {
          goToSelectAppointment();
        },
      ),
      DashboardQuickAction(
        title: 'Riwayat',
        icon: Icons.assignment_rounded,
        iconBackgroundColor: Color(0xFFF8ECD8),
        iconColor: Color(0xFFE0A548),
        onTap: () {
          goToBookingList();
        },
      ),
    ];

    await getDashboardData();
    await getRegions();
  }

  void goToSelectAppointment() {
    ctx.pushNamed(RouterRoutes.selectAppointment.name);
  }

  void goToBookingList() {
    ctx.pushNamed(RouterRoutes.bookingList.name);
  }

  void onQuickActionTap(DashboardQuickAction action) {
    showToast('${action.title} belum tersedia.');
  }

  void onRegionChanged() async {
    await getBookingList();
  }

  void onNavTap(int index) {
    selectedNavIndex = index;
    notifyListeners();
  }

  Future<void> logout() async {
    isLoading = true;
    await HiveHelper.clearSession();
    FlavorConfig.instance?.values.token = '';
    isLoading = false;
    ctx.pushReplacementNamed(RouterRoutes.login.name);
  }

  getDashboardData() async {
    final response = await _services.getDashboardData();

    if (response is DioException) {
      String errorMsg =
          response.response == null
              ? "Internal server error."
              : response.response!.data['error']['message'];
      showErrorToast(errorMsg);
      return;
    }

    final data = response.data;
    if (data['recentBooking'] != null) {
      recentBooking = BookingModel.fromResponseBody(data['recentBooking']);
    }
    profile = ProfileModel.fromResponseBody(data['user']);
  }

  getRegions() async {
    final response = await _services.getRegions();

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
  }

  getBookingList() async {
    if (form.region.selectedValue == null) return;
    final response = await _services.getBookingList(
      regionId: form.region.selectedValue!.id,
    );

    if (response is DioException) {
      String errorMsg =
          response.response == null
              ? "Internal server error."
              : response.response!.data['error']['message'];
      showErrorToast(errorMsg);
      return;
    }

    final data = response.data['encounter'];
    selectedBookings =
        (data as List<dynamic>)
            .map((item) => BookingModel.fromResponseBody(item))
            .toList();
    notifyListeners();
  }
}
