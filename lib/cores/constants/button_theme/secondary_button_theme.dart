import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';

final secondaryButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    splashFactory: InkRipple.splashFactory,
    overlayColor: WidgetStateProperty.resolveWith<Color>(
      (states) => AppColors.black.withValues(alpha: 0.05),
    ),
    padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
      (states) => EdgeInsets.symmetric(horizontal: 12.w),
    ),
    shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
      (_) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
    ),
    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.buttonDisabled;
      }
      return AppColors.transparent;
    }),
    side: WidgetStateProperty.resolveWith<BorderSide>((states) {
      if (states.contains(WidgetState.disabled)) {
        return BorderSide(color: AppColors.buttonDisabled);
      }
      return BorderSide(color: AppColors.primary, width: 1);
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled)) return AppColors.white;
      return AppColors.primary;
    }),
    textStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (states) => textTheme.buttonText.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        fontFamily: 'DMSans',
      ),
    ),
    elevation: WidgetStateProperty.resolveWith<double>((states) => 0),
    minimumSize: WidgetStateProperty.resolveWith<Size>(
      (states) => const Size(double.minPositive, double.minPositive),
    ),
  ),
);
