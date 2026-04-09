import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/bases/base_view.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/utils/datetime_extension.dart';
import 'package:klinikku/cores/widgets/tap_detector.dart';
import 'package:klinikku/features/booking/models/booking_model.dart';
import 'package:klinikku/features/booking/viewmodels/booking_list_viewmodel.dart';

class BookingListView extends StatelessWidget {
  const BookingListView({super.key});

  @override
  Widget build(BuildContext context) =>
      BaseView(provider: bookingListVM, builder: _buildScreen);

  Widget _buildScreen(BuildContext context, BookingListVM vm) => SafeArea(
    bottom: false,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(vm),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterTabs(vm),
                Gap(18.h),
                if (vm.filteredBookings.isEmpty)
                  _buildEmptyState()
                else
                  Column(
                    children:
                        vm.filteredBookings.map((item) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: _BookingCard(item: item),
                          );
                        }).toList(),
                  ),
                Gap(100.h),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildHeader(BookingListVM vm) => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 26.h),
    decoration: const BoxDecoration(color: Color(0xFF3A7F77)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(2.h),
        InkWell(
          onTap: () => Navigator.of(ctx).maybePop(),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.white,
                  size: 20.sp,
                ),
                Gap(6.w),
                Text(
                  'Kembali ke Slot',
                  style: textTheme.body6.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(16.h),
        Row(
          children: [
            Expanded(
              child: Text(
                'Booking Saya',
                style: textTheme.headline1.copyWith(
                  color: AppColors.white,
                  height: 1.15,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildFilterTabs(BookingListVM vm) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    physics: const BouncingScrollPhysics(),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(vm.filterLabels.length, (index) {
        final isSelected = vm.selectedFilterIndex == index;
        return Padding(
          padding: EdgeInsets.only(
            right: index == vm.filterLabels.length - 1 ? 0 : 10.w,
          ),
          child: InkWell(
            onTap: () => vm.selectFilter(index),
            borderRadius: BorderRadius.circular(999.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.gray2,
                ),
              ),
              child: Text(
                vm.filterLabels[index],
                style: textTheme.body5.copyWith(
                  color: isSelected ? AppColors.white : AppColors.gray1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );

  Widget _buildEmptyState() => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 18.w),
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
        Icon(Icons.event_busy_rounded, size: 34.sp, color: AppColors.gray1),
        Gap(10.h),
        Text(
          'Belum ada booking pada filter ini',
          style: textTheme.body5.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        Gap(4.h),
        Text(
          'Coba pilih kategori booking yang lain.',
          style: textTheme.body6.copyWith(color: AppColors.gray1),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class _BookingCard extends StatelessWidget {
  final BookingModel item;

  const _BookingCard({required this.item});

  @override
  Widget build(BuildContext context) => TapDetector(
    onTap: () {
      ctx.pushNamed(RouterRoutes.bookingDetail.name, extra: {'id': item.id});
    },
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.bookingCode,
                      style: textTheme.body6.copyWith(
                        color: AppColors.gray1,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      item.doctor.name,
                      style: textTheme.body2.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    Gap(2.h),
                    Text(
                      '${item.doctor.specialization} · ${item.region.name}',
                      style: textTheme.body6.copyWith(color: AppColors.gray1),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: item.statusBackgroundColor,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  item.statusLabel,
                  style: textTheme.caption1.copyWith(
                    color: item.statusTextColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          Gap(14.h),
          Divider(height: 1, thickness: 1, color: AppColors.gray2),
          Gap(12.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${item.appointmentSlot.date.toIndonesianShortDayDateString()} | ${item.appointmentSlot.timeRangeText}',
                  style: textTheme.body6.copyWith(
                    color: AppColors.gray1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF5F4),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.primary,
                  size: 28.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
