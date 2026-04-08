import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/features/dashboard/models/dashboard_stat.dart';

class StatCard extends StatelessWidget {
  final DashboardStat stat;

  const StatCard({required this.stat});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18.r),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.05),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stat.value,
          style: textTheme.headline2.copyWith(
            color: AppColors.black,
            height: 1.1,
          ),
        ),
        Gap(6.h),
        Text(
          stat.label,
          style: textTheme.body6.copyWith(color: AppColors.gray1, height: 1.3),
        ),
      ],
    ),
  );
}
