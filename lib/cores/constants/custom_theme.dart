import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/models/custom_theme_model.dart';

class CustomTheme {
  static CustomThemeModel get lightTheme => CustomThemeModel(
    themeData: ThemeData(
      colorScheme: const ColorScheme.light().copyWith(
        onSurface: AppColors.primary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        dragHandleSize: Size(32.w, 3.75.h),
      ),
      tabBarTheme: TabBarThemeData(
        indicatorColor: AppColors.primary,
        dividerHeight: 0,
        labelPadding: EdgeInsets.only(bottom: 8.h),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          side: WidgetStateBorderSide.resolveWith((_) => null),
          shape: WidgetStateProperty.resolveWith((_) => null),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
        ),
      ),
      primaryColor: AppColors.primary,
      brightness: Brightness.light,
      fontFamily: 'DMSans',
      scaffoldBackgroundColor: AppColors.white,
      splashColor: AppColors.transparent,
    ),
    name: 'light',
  );
}
