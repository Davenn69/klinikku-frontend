import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/widgets/tap_detector.dart';

class CustomToast extends StatelessWidget {
  final String text;
  final String? title;
  final bool isError;
  final bool isSuccess;
  final Color? customColor;
  final Color? customTextColor;
  final Function()? onTapError;

  const CustomToast({
    super.key,
    this.title,
    this.text = 'text here',
    this.isError = false,
    this.isSuccess = false,
    this.onTapError,
    this.customColor,
    this.customTextColor,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
    child: TapDetector(
      onTap: onTapError,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSuccess ? AppColors.primary : AppColors.warning,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .3), // Updated method
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isError || isSuccess)
              Icon(
                isError ? Icons.close : Icons.check,
                color: AppColors.white,
                size: 24.w,
              ),
            Gap(10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null) ...[
                    Text(title!, style: textTheme.body5.copyWith()),
                  ],
                  Text(
                    text,
                    style: textTheme.body6.copyWith(
                      color: customTextColor ?? AppColors.white,
                      fontFamily: 'DMSans',
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
