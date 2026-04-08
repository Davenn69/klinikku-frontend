import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:klinikku/cores/bases/base_view.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/features/dashboard/viewmodels/dashboard_viewmodel.dart';
import 'package:klinikku/features/dashboard/widgets/quick_action_card.dart';
import 'package:klinikku/features/dashboard/widgets/stat_card.dart';

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
                Transform.translate(
                  offset: Offset(0, -36.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatsRow(vm),
                        Gap(16.h),
                        _buildSectionTitle('Aksi Cepat'),
                        Gap(16.h),
                        _buildQuickActions(vm),
                        _buildSectionTitle('Booking Terdekat'),
                        Gap(14.h),
                        _buildUpcomingBooking(vm),
                      ],
                    ),
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
                    vm.currentDateLabel,
                    style: textTheme.caption2.copyWith(
                      color: AppColors.gray3,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    'Halo, ${vm.greetingName}! 👋',
                    style: textTheme.headline1.copyWith(height: 1.2),
                  ),
                ],
              ),
            ),
            Container(
              width: 44.w,
              height: 44.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.22),
                shape: BoxShape.circle,
              ),
              child: Text(
                'BS',
                style: textTheme.body5.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildStatsRow(DashboardVM vm) => Row(
    children:
        vm.stats
            .map(
              (stat) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: StatCard(stat: stat),
                ),
              ),
            )
            .toList(),
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
      return QuickActionCard(
        action: action,
        onTap: () => vm.onQuickActionTap(action),
      );
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
                vm.upcomingBooking.scheduleLabel,
                style: textTheme.caption1.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(8.h),
              Text(
                vm.upcomingBooking.doctorName,
                style: textTheme.body2.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                vm.upcomingBooking.specialization,
                style: textTheme.body6.copyWith(color: AppColors.gray1),
              ),
              Gap(16.h),
              Row(
                children: [
                  Text(
                    vm.upcomingBooking.status,
                    style: textTheme.body5.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(22.w),
                  Expanded(
                    child: Text(
                      vm.upcomingBooking.bookingCode,
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

  // Widget _buildBottomNavigation(DashboardVM vm) => Container(
  //   padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 20.h),
  //   decoration: BoxDecoration(
  //     color: AppColors.white,
  //     boxShadow: [
  //       BoxShadow(
  //         color: AppColors.black.withValues(alpha: 0.05),
  //         blurRadius: 18,
  //         offset: const Offset(0, -4),
  //       ),
  //     ],
  //   ),
  //   child: Row(
  //     children: List.generate(vm.navigationItems.length, (index) {
  //       final item = vm.navigationItems[index];
  //       final isSelected = vm.selectedNavIndex == index;

  //       return Expanded(
  //         child: InkWell(
  //           onTap: () => vm.onNavTap(index),
  //           borderRadius: BorderRadius.circular(16.r),
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(vertical: 4.h),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Icon(
  //                   item.icon,
  //                   size: 22.sp,
  //                   color: isSelected ? AppColors.primary : AppColors.gray1,
  //                 ),
  //                 Gap(4.h),
  //                 Text(
  //                   item.label,
  //                   style: textTheme.caption1.copyWith(
  //                     color: isSelected ? AppColors.primary : AppColors.gray1,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     }),
  //   ),
  // );
}
