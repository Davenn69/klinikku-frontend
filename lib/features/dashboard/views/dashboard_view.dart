import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:klinikku/cores/bases/base_view.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/utils/datetime_extension.dart';
import 'package:klinikku/features/dashboard/viewmodels/dashboard_viewmodel.dart';
import 'package:klinikku/features/dashboard/widgets/quick_action_card.dart';

enum _ProfileMenuAction { logout }

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) => BaseView(
    provider: dashboardVM,
    backgroundColor: const Color(0xFFF7F8F5),
    builder: _buildScreen,
  );

  Widget _buildScreen(BuildContext context, DashboardVM vm) => SafeArea(
    bottom: false,
    child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroSection(vm),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(16.h),
                      _buildSectionTitle('Aksi Cepat'),
                      Gap(16.h),
                      _buildQuickActions(vm),
                      _buildSectionTitle('Booking Terdekat'),
                      Gap(16.h),
                      _buildUpcomingBooking(vm),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildHeroSection(DashboardVM vm) => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(22.w, 16.h, 22.w, 48.h),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF3A7F77), Color(0xFF4AA291)],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vm.currentDateLabel.toIndonesianDayDateString(),
                    style: textTheme.caption2.copyWith(
                      color: AppColors.gray3,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    'Halo, ${vm.profile.name}! 👋',
                    style: textTheme.headline1.copyWith(height: 1.2),
                  ),
                ],
              ),
            ),
            PopupMenuButton<_ProfileMenuAction>(
              position: PopupMenuPosition.under,
              offset: Offset(0, 12.h),
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              onSelected: (action) {
                switch (action) {
                  case _ProfileMenuAction.logout:
                    _confirmLogout(ctx, vm);
                    break;
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: _ProfileMenuAction.logout,
                      child: Row(
                        children: [
                          Text(
                            'Logout',
                            style: textTheme.body5.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
              child: Container(
                width: 44.w,
                height: 44.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.22),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  vm.profile.name.isNotEmpty ? vm.profile.name[0] : '?',
                  style: textTheme.body5.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildSectionTitle(String title) =>
      Text(title, style: textTheme.subHeadline1);

  Widget _buildQuickActions(DashboardVM vm) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: vm.quickActions.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 14.w,
      mainAxisSpacing: 14.h,
      mainAxisExtent: 102.h,
    ),
    itemBuilder: (context, index) {
      final action = vm.quickActions[index];
      return QuickActionCard(action: action, onTap: () => action.onTap());
    },
  );

  Widget _buildUpcomingBooking(DashboardVM vm) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.w),
    decoration: BoxDecoration(
      color: const Color(0xFFDDEDEC),
      borderRadius: BorderRadius.circular(22.r),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.05),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4.w,
          height: 108.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(999.r),
          ),
        ),
        Gap(14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${vm.recentBooking.appointmentSlot.startTime} - ${vm.recentBooking.appointmentSlot.endTime}",
                style: textTheme.caption1.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(8.h),
              Text(
                vm.recentBooking.doctor.name,
                style: textTheme.body2.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                vm.recentBooking.doctor.specialization,
                style: textTheme.body6.copyWith(color: AppColors.gray1),
              ),
              Gap(16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vm.recentBooking.statusLabel,
                    style: textTheme.body5.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(22.w),
                  Expanded(
                    child: Text(
                      vm.recentBooking.bookingCode,
                      style: textTheme.body6.copyWith(color: AppColors.gray1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Future<void> _confirmLogout(BuildContext context, DashboardVM vm) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(
              'Logout',
              style: textTheme.headline1.copyWith(color: AppColors.black),
            ),
            content: Text(
              'Apakah kamu yakin ingin keluar dari akun ini?',
              style: textTheme.body6.copyWith(color: AppColors.black),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(
                  'Batal',
                  style: textTheme.body6.copyWith(color: AppColors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.warning,
                  foregroundColor: AppColors.white,
                ),
                child: Text('Logout'),
              ),
            ],
          ),
    );

    if (shouldLogout == true) {
      await vm.logout();
    }
  }
}
