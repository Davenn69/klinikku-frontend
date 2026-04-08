import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/models/text_input_model.dart';

class CustomTextField extends StatefulWidget {
  final TextInputModel inputModel;
  final FocusNode? focusNode;
  final Function()? onTapOutside;
  final bool enabled;
  final String hint;
  final String? label;
  final TextStyle? labelStyle;
  final String? errorMessage;
  final String? Function(String)? validator;
  final void Function(String)? onValidate;
  final Function(String)? onSubmit;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Function()? onSuffixPressed;
  final Function(String)? onChanged;
  final EdgeInsets? contentPadding;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final bool isLarge;
  final TextStyle? style;
  final Color labelColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final InlineSpan? toolTip;
  final Color? hintColor;

  const CustomTextField({
    super.key,
    this.focusNode,
    this.onTapOutside,
    this.enabled = true,
    required this.hint,
    this.label,
    this.labelStyle,
    this.errorMessage,
    required this.inputModel,
    required this.onSubmit,
    this.validator,
    this.prefixWidget,
    this.suffixWidget,
    this.onSuffixPressed,
    this.onValidate,
    this.onChanged,
    this.contentPadding,
    this.inputAction,
    this.keyboardType,
    this.autoFocus = false,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.isLarge = false, // Default is not large,
    this.style,
    this.labelColor = AppColors.black,
    this.borderRadius,
    this.borderColor,
    this.toolTip,
    this.hintColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorMessage;

  InputBorder getBorder(Color color) => OutlineInputBorder(
    borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
    borderSide: BorderSide(
      color:
          widget.borderColor ??
          (errorMessage != null ? AppColors.warning : color),
      width: 1.0,
    ),
  );
  String? validate(String value) {
    if (value.isEmpty) {
      return 'Data is empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (widget.label != null) ...[
        Text(widget.label!.toUpperCase(), style: textTheme.caption1),
        Gap(6.h),
      ],
      SizedBox(
        height: widget.isLarge ? 125.h : 46.h,
        child: TextFormField(
          expands: widget.isLarge,
          maxLines: widget.isLarge ? null : 1,
          textAlignVertical:
              widget.isLarge ? TextAlignVertical.top : TextAlignVertical.center,
          focusNode: widget.focusNode,
          onTapOutside: (_) {
            widget.onTapOutside?.call();
          },
          autofocus: widget.autoFocus,
          textInputAction: widget.inputAction,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          controller: widget.inputModel.controller,
          onChanged: (value) {
            setState(() {
              errorMessage = null;
            });
            widget.onChanged?.call(value);
          },
          textAlign: widget.textAlign,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            contentPadding:
                widget.contentPadding ??
                EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
            hintText: widget.hint,
            hintStyle: textTheme.body6.copyWith(
              color: widget.hintColor ?? AppColors.gray2,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: widget.enabled ? AppColors.white : AppColors.gray1,
            focusedBorder: getBorder(AppColors.primary),
            enabledBorder: getBorder(AppColors.gray2),
            disabledBorder: getBorder(AppColors.gray2),
            border: getBorder(AppColors.gray2),
            errorBorder: getBorder(AppColors.gray2),
            focusedErrorBorder: getBorder(AppColors.primary),
            errorStyle: textTheme.body6.copyWith(
              fontSize: 0,
              color: Colors.transparent,
            ),
            prefixIcon: widget.prefixWidget,
            prefixIconConstraints: BoxConstraints(
              maxWidth: 120.w,
              maxHeight: 23.h,
            ),
            suffixIcon: widget.suffixWidget,
            suffixIconConstraints: BoxConstraints(
              maxWidth: 56.w,
              maxHeight: 23.h,
            ),
          ),
          style: (widget.style ?? textTheme.body6).copyWith(
            color:
                !widget.enabled
                    ? AppColors.gray1
                    : (errorMessage != null
                        ? AppColors.warning
                        : AppColors.black),
          ),
          showCursor: true,
          cursorColor:
              errorMessage != null ? AppColors.warning : AppColors.primary,
          cursorErrorColor:
              errorMessage != null ? AppColors.warning : AppColors.primary,
          validator: (value) {
            String? message = widget.inputModel.validator?.call(value ?? '');
            if (message != null) {
              setState(() {
                errorMessage = message;
              });
            }
            widget.onValidate?.call(message!);
            return message;
          },
          onFieldSubmitted: widget.onSubmit,
          inputFormatters: [...?widget.inputFormatters],
        ),
      ),
      if (errorMessage != null) ...[
        Gap(3.h),
        Text(
          errorMessage!,
          style: textTheme.body6.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.warning,
          ),
        ),
      ],
    ],
  );
}
