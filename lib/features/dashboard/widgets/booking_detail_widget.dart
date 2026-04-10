import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/utils/datetime_extension.dart';
import 'package:klinikku/features/booking/models/booking_model.dart';

class BookingDetailWidget extends StatelessWidget {
  final BookingModel data;
  const BookingDetailWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) => Container(
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
                "${data.appointmentSlot.date.toIndonesianShortDayDateString()} | ${data.appointmentSlot.timeRangeText}",
                style: textTheme.caption1.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(8.h),
              Text(
                data.doctor.name,
                style: textTheme.body2.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                data.doctor.specialization,
                style: textTheme.body6.copyWith(color: AppColors.gray1),
              ),
              Gap(16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.statusLabel,
                    style: textTheme.body5.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(22.w),
                  Expanded(
                    child: Text(
                      data.bookingCode,
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
}
