import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';

class DayTile extends StatelessWidget {
  final String dayNumber;
  final String dayLabel;
  final bool isSelected;
  final VoidCallback onTap;

  const DayTile({
    super.key,
    required this.dayNumber,
    required this.dayLabel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16.r),
    child: Container(
      width: 62.w,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.gray2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayNumber,
            style: textTheme.body2.copyWith(
              color: isSelected ? AppColors.white : AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(2.h),
          Text(
            dayLabel,
            style: textTheme.caption1.copyWith(
              color: isSelected ? AppColors.white : AppColors.gray1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
