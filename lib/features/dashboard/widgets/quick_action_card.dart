import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/features/dashboard/models/dashboard_quick_action.dart';

class QuickActionCard extends StatelessWidget {
  final DashboardQuickAction action;
  final VoidCallback onTap;

  const QuickActionCard({super.key, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(20.r),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.gray2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: action.iconBackgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(action.icon, color: action.iconColor, size: 20.sp),
            ),
            Text(action.title, style: textTheme.body2),
          ],
        ),
      ),
    ),
  );
}
