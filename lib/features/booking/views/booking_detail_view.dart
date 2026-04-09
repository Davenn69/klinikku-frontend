import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:klinikku/cores/bases/base_view.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/utils/datetime_extension.dart';
import 'package:klinikku/cores/widgets/custom_button.dart';
import 'package:klinikku/features/booking/models/booking_model.dart';
import 'package:klinikku/features/booking/viewmodels/booking_detail_viewmodel.dart';

class BookingDetailView extends StatelessWidget {
  final String bookingId;
  final AutoDisposeChangeNotifierProvider<BookingDetailVM> bookingDetailVM;
  BookingDetailView({super.key, required this.bookingId})
    : bookingDetailVM = ChangeNotifierProvider.autoDispose<BookingDetailVM>(
        (ref) => BookingDetailVM(ref, bookingId: bookingId),
      );

  @override
  Widget build(BuildContext context) => BaseView(
    provider: bookingDetailVM,
    backgroundColor: const Color(0xFFF7F8F5),
    builder: _buildScreen,
  );

  Widget _buildScreen(BuildContext context, BookingDetailVM vm) => SafeArea(
    bottom: false,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, vm),
          Gap(8.h),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Dokter',
                  style: textTheme.subHeadline1.copyWith(
                    color: AppColors.black,
                    height: 1.2,
                  ),
                ),
                _buildInfoRow('Nama Dokter', vm.detail.doctor.name),
                _buildDivider(),
                _buildInfoRow('Spesialisasi', vm.detail.doctor.specialization),
                Text(
                  'Jadwal Appointment',
                  style: textTheme.subHeadline1.copyWith(
                    color: AppColors.black,
                    height: 1.2,
                  ),
                ),
                _buildInfoRow(
                  'Tanggal',
                  vm.detail.appointmentSlot.date.toIndonesianDayDateString(),
                ),
                _buildDivider(),
                _buildInfoRow(
                  'Jam',
                  vm.detail.appointmentSlot.timeRangeText,
                  valueStyle: textTheme.body6.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _buildDivider(),
                _buildInfoRow('Region', vm.detail.region.name),
                if (vm.detail.complaint != null) ...[
                  Gap(16.h),
                  Text(
                    'Keluhan Pasien',
                    style: textTheme.subHeadline1.copyWith(
                      color: AppColors.black,
                      height: 1.2,
                    ),
                  ),
                  Gap(16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F0E4),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Text(
                      vm.detail.complaint!,
                      style: textTheme.body6.copyWith(
                        color: AppColors.black,
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
                if (vm.detail.status == BookingListStatus.booked) ...[
                  Gap(16.h),
                  Button(
                    isCancel: true,
                    text: 'Batalkan Booking Ini',
                    onPressed: () => vm.deleteBooking(),
                  ),
                ],
                Gap(48.h),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildHeader(BuildContext context, BookingDetailVM vm) => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 30.h),
    decoration: const BoxDecoration(color: AppColors.primary),
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
                  'Daftar Booking',
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
        Center(
          child: Column(
            children: [
              Text(
                'Detail Booking',
                style: textTheme.headline1.copyWith(
                  color: AppColors.white,
                  height: 1.15,
                ),
              ),
              Gap(14.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Text(
                  vm.detail.bookingCode,
                  style: textTheme.body2.copyWith(
                    color: AppColors.white,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Gap(18.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F7F5),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  vm.detail.statusLabel,
                  style: textTheme.body5.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildInfoRow(String label, String value, {TextStyle? valueStyle}) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Text(
                label,
                style: textTheme.body6.copyWith(
                  color: AppColors.gray1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style:
                    valueStyle ??
                    textTheme.body6.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
      );

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: AppColors.gray2);
}
