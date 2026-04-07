import 'dart:ui';

import 'package:klinikku/cores/widgets/custom_toast.dart';
import 'package:oktoast/oktoast.dart';

mixin ToastMixin {
  void showErrorToast(String message, {ToastPosition? position}) {
    _showCustomToast(message: message, isError: true, position: position);
  }

  void showToast(String message, {ToastPosition? position}) {
    _showCustomToast(message: message, position: position);
  }

  void showSuccessToast(String message, {ToastPosition? position}) {
    _showCustomToast(message: message, position: position, isSuccess: true);
  }

  void showToastWithTitle({
    required String title,
    required String message,
    ToastPosition? position,
    Color? customTextColor,
    Color? customColor,
  }) {
    _showCustomToast(
      message: message,
      title: title,
      position: position,
      customTextColor: customTextColor,
      customColor: customColor,
    );
  }

  void _showCustomToast({
    required String message,
    bool isError = false,
    bool isSuccess = false,
    String? title,
    ToastPosition? position,
    Color? customTextColor,
    Color? customColor,
  }) {
    showToastWidget(
      CustomToast(
        title: title,
        text: message,
        isError: isError,
        isSuccess: isSuccess,
        onTapError: isError ? dismissAllToast : null,
        customColor: customColor,
        customTextColor: customTextColor,
      ),
      position: position ?? ToastPosition.bottom,
      duration: const Duration(seconds: 3),
      handleTouch: true,
    );
  }
}
