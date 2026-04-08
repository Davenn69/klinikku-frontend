import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klinikku/cores/bases/base_notifier.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/features/dashboard/models/dashboard_nav_item.dart';
import 'package:klinikku/features/dashboard/models/dashboard_quick_action.dart';
import 'package:klinikku/features/dashboard/models/dashboard_stat.dart';
import 'package:klinikku/features/dashboard/models/upcoming_booking.dart';

final dashboardVM = ChangeNotifierProvider.autoDispose(DashboardVM.new);

class DashboardVM extends BaseNotifier with ToastMixin {
  late List<DashboardStat> stats;
  late List<DashboardQuickAction> quickActions;
  late UpcomingBooking upcomingBooking;
  late List<DashboardNavItem> navigationItems;

  String greetingName = 'Budi';
  String currentDateLabel = 'Selasa, 7 April 2026';
  int selectedNavIndex = 0;

  DashboardVM(super.ref);

  @override
  FutureOr<void> init() {
    stats = const [
      DashboardStat(value: '2', label: 'Booking Aktif'),
      DashboardStat(value: '5', label: 'Total Kunjungan'),
      DashboardStat(value: '3', label: 'Dokter Pernah Dikunjungi'),
    ];

    quickActions = const [
      DashboardQuickAction(
        title: 'Buat Booking',
        icon: Icons.event_available_rounded,
        iconBackgroundColor: Color(0xFFE2F1EE),
        iconColor: Color(0xFF3A7F77),
      ),
      DashboardQuickAction(
        title: 'Riwayat Booking',
        icon: Icons.assignment_rounded,
        iconBackgroundColor: Color(0xFFF8ECD8),
        iconColor: Color(0xFFE0A548),
      ),
      DashboardQuickAction(
        title: 'Dokter Tersedia',
        icon: Icons.check_circle_rounded,
        iconBackgroundColor: Color(0xFFE4F3E6),
        iconColor: Color(0xFF54A066),
      ),
      DashboardQuickAction(
        title: 'Pilih Region',
        icon: Icons.location_on_rounded,
        iconBackgroundColor: Color(0xFFE5ECFB),
        iconColor: Color(0xFF4D73BE),
      ),
    ];

    upcomingBooking = const UpcomingBooking(
      scheduleLabel: 'BESOK • 08:00 - 08:30',
      doctorName: 'dr. Andi Wijaya, Sp.PD',
      specialization: 'Penyakit Dalam · RS Klinik Surabaya',
      status: 'BOOKED',
      bookingCode: 'BKG-20260407-001',
    );

    navigationItems = const [
      DashboardNavItem(label: 'Beranda', icon: Icons.home_rounded),
      DashboardNavItem(label: 'Booking', icon: Icons.calendar_today_rounded),
      DashboardNavItem(label: 'Riwayat', icon: Icons.receipt_long_rounded),
      DashboardNavItem(label: 'Profil', icon: Icons.person_rounded),
    ];
  }

  void onQuickActionTap(DashboardQuickAction action) {
    showToast('${action.title} belum tersedia.');
  }

  void onNavTap(int index) {
    selectedNavIndex = index;
    notifyListeners();
  }
}
