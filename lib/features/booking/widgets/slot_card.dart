import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/widgets/custom_button.dart';
import 'package:klinikku/features/booking/models/appointment_slot_item.dart';

class SlotCard extends StatelessWidget {
  final AppointmentSlotItem slot;
  final String doctorSpecialization;
  final VoidCallback? onTap;

  const SlotCard({
    super.key,
    required this.slot,
    required this.onTap,
    required this.doctorSpecialization,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18.r),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.04),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                slot.timeRangeText,
                style: textTheme.body2.copyWith(
                  color: slot.isAvailable ? AppColors.black : AppColors.gray1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(2.h),
              Text(
                '${slot.durationText} - $doctorSpecialization',
                style: textTheme.body6.copyWith(color: AppColors.gray1),
              ),
            ],
          ),
        ),
        Button(
          text: slot.isAvailable ? 'Pilih' : 'Penuh',
          onPressed: onTap,
          width: 74.w,
          height: 40.h,
          textStyle:
              slot.isAvailable
                  ? textTheme.button.copyWith(fontSize: 13.sp)
                  : textTheme.button.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.gray1,
                  ),
        ),
      ],
    ),
  );
}
