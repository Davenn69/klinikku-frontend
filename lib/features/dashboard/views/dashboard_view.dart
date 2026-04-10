import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/bases/base_view.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/utils/datetime_extension.dart';
import 'package:klinikku/cores/widgets/custom_dropdown.dart';
import 'package:klinikku/cores/widgets/tap_detector.dart';
import 'package:klinikku/features/booking/models/region_model.dart';
import 'package:klinikku/features/dashboard/viewmodels/dashboard_viewmodel.dart';
import 'package:klinikku/features/dashboard/widgets/booking_detail_widget.dart';
import 'package:klinikku/features/dashboard/widgets/quick_action_card.dart';

enum _ProfileMenuAction { logout }

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) =>
      BaseView(provider: dashboardVM, builder: _buildScreen);

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
                      if (vm.recentBooking != null)
                        _buildUpcomingBooking(vm)
                      else
                        _buildEmptyState(
                          title: 'Belum ada booking terdekat',
                          message:
                              'Booking aktif akan muncul di sini setelah kamu membuat janji.',
                          icon: Icons.event_busy_rounded,
                        ),
                      Gap(16.h),
                      if (vm.regions.isNotEmpty) ...[
                        _buildSectionTitle('Booking Berdasarkan Lokasi'),
                        Gap(16.h),
                        CustomDropdownButton<RegionModel>(
                          options: vm.regions,
                          hint: 'Pilih region',
                          label: 'REGION',
                          inputModel: vm.form.region,
                          getLabel: (value) => value?.name ?? '',
                          onValueChanged: (data) => vm.onRegionChanged(),
                        ),
                        Gap(16.h),
                        if (vm.selectedBookings != null) ...[
                          if (vm.selectedBookings!.isEmpty) ...[
                            _buildEmptyState(
                              title: 'Belum ada booking di region ini',
                              message:
                                  'Coba pilih region lain untuk melihat daftar booking yang tersedia.',
                              icon: Icons.map_outlined,
                            ),
                          ] else ...[
                            Column(
                              children:
                                  vm.selectedBookings!
                                      .map(
                                        (item) => Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 16.h,
                                          ),
                                          child: TapDetector(
                                            onTap: () {
                                              ctx.pushNamed(
                                                RouterRoutes.bookingDetail.name,
                                                extra: {'id': item.id},
                                              );
                                            },
                                            child: BookingDetailWidget(
                                              data: item,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ],
                        ],
                      ],
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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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

  Widget _buildEmptyState({
    required String title,
    required String message,
    required IconData icon,
  }) => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 18.w),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(22.r),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.04),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, size: 34.sp, color: AppColors.gray1),
        Gap(10.h),
        Text(
          title,
          style: textTheme.body5.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        Gap(4.h),
        Text(
          message,
          style: textTheme.body6.copyWith(color: AppColors.gray1),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

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

  Widget _buildUpcomingBooking(DashboardVM vm) => TapDetector(
    onTap: () {
      ctx.pushNamed(
        RouterRoutes.bookingDetail.name,
        extra: {'id': vm.recentBooking!.id},
      );
    },
    child: BookingDetailWidget(data: vm.recentBooking!),
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
