import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class _TextTheme {
  // Typography
  final headline1 = TextStyle(
    fontSize: 40.sp,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    height: 1.5,
  );

  final headline2 = TextStyle(
    fontSize: 32.sp,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  final headline3 = TextStyle(
    fontSize: 24.sp,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  final headline4 = TextStyle(
    fontSize: 21.sp,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    height: 1.5,
  );

  final subHeadline1 = TextStyle(
    fontSize: 18.sp,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  );

  final subHeadline2 = TextStyle(
    fontSize: 18.sp,
    color: AppColors.black,
    fontWeight: FontWeight.normal,
  );

  final body1 = TextStyle(
    fontSize: 16.5.sp,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    height: 1.5,
  );

  final body2 = TextStyle(
    fontSize: 16.5.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    height: 1.5,
  );

  final body3 = TextStyle(
    fontSize: 16.5.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    height: 1.5,
  );

  final body4 = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    height: 1.5,
  );

  final body5 = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    height: 1.5,
  );

  final body6 = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    height: 1.5,
  );

  final labelMenu = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  final labelUppercase = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    height: 1.5,
    letterSpacing: 0.65,
  );

  final button = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  final buttonText = TextStyle(fontSize: 15.sp, color: AppColors.white);
}

final textTheme = _TextTheme();
