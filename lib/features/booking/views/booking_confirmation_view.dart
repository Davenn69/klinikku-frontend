import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/bases/base_view.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/utils/datetime_extension.dart';
import 'package:klinikku/cores/widgets/custom_button.dart';
import 'package:klinikku/cores/widgets/custom_text_field.dart';
import 'package:klinikku/features/booking/models/booking_confirmation_model.dart';
import 'package:klinikku/features/booking/viewmodels/booking_confirmation_viewmodel.dart';

class BookingConfirmationView extends StatelessWidget {
  final BookingConfirmationModel data;
  final bool isUpdate;
  final String bookingId;
  const BookingConfirmationView({
    super.key,
    required this.data,
    this.bookingId = '',
    this.isUpdate = false,
  });

  @override
  Widget build(BuildContext context) =>
      BaseView(provider: bookingConfirmationVm, builder: _buildScreen);

  Widget _buildScreen(BuildContext context, BookingConfirmationVM vm) =>
      SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Form(
            key: vm.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Appointment',
                        style: textTheme.subHeadline1.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      Gap(14.h),
                      _buildAppointmentCard(),
                      Gap(18.h),
                      CustomTextField(
                        label: 'Keluhan (Opsional)',
                        hint: 'Masukkan keluhan Anda',
                        inputModel: vm.form.complaint,
                        isLarge: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          16.w,
                          14.h,
                          16.w,
                          14.h,
                        ),
                        style: textTheme.body6.copyWith(color: AppColors.black),
                        onSubmit: (_) {},
                      ),
                      Gap(22.h),
                      Button(
                        text: 'Konfirmasi Booking',
                        leadingWidget: Icon(
                          Icons.check_rounded,
                          size: 20.sp,
                          color: AppColors.white,
                        ),
                        onPressed:
                            () => vm.confirmBooking(
                              data.doctor.id,
                              data.region.id,
                              data.appointment.id,
                              isUpdate,
                              bookingId,
                            ),
                        height: 54.h,
                      ),
                      Gap(14.h),
                      Button(
                        text: 'Batalkan',
                        isSecondary: true,
                        onPressed: () {
                          ctx.pop();
                        },
                        height: 54.h,
                        textStyle: textTheme.button.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildHeader(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
    decoration: BoxDecoration(color: AppColors.primary),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(2.h),
        InkWell(
          onTap: () => Navigator.of(context).maybePop(),
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
        Text(
          'Konfirmasi Booking',
          style: textTheme.headline1.copyWith(
            color: AppColors.white,
            height: 1.15,
          ),
        ),
      ],
    ),
  );

  Widget _buildAppointmentCard() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: const Color(0xFFEAF5F4),
      borderRadius: BorderRadius.circular(18.r),
      border: Border.all(color: const Color(0xFFD0E5E2)),
    ),
    child: Column(
      children: [
        _buildDetailRow('Dokter', data.doctor.name),
        Gap(10.h),
        _buildDetailRow('Spesialisasi', data.doctor.specialization),
        Gap(10.h),
        _buildDetailRow('Region', data.region.name),
        Gap(10.h),
        _buildDetailRow(
          'Tanggal',
          data.appointment.date.toIndonesianDayDateString(),
        ),
        Gap(10.h),
        _buildDetailRow(
          'Jam',
          data.appointment.timeRangeText,
          valueStyle: textTheme.body4.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );

  Widget _buildDetailRow(String label, String value, {TextStyle? valueStyle}) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92.w,
            child: Text(
              label,
              style: textTheme.body6.copyWith(
                color: AppColors.gray1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
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
      );
}
