import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class _TextTheme {
  // Typography
  final headline1 = TextStyle(
    fontSize: 24.sp,
    color: AppColors.white,
    height: 1.5,
    fontFamily: "DMSerif",
  );

  final headline2 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.white,
    height: 1.5,
    fontFamily: "DMSerif",
  );

  final subHeadline1 = TextStyle(
    fontSize: 18.sp,
    color: AppColors.black,
    height: 1.5,
    fontFamily: "DMSerif",
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

  final caption1 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.gray1,
    height: 1.5,
  );

  final caption2 = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w300,
    color: AppColors.gray3,
    height: 1.5,
  );

  final button = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  final buttonText = TextStyle(fontSize: 15.sp, color: AppColors.white);
}

final textTheme = _TextTheme();
