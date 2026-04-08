import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/mixins/debounce_mixin.dart';

import '../models/text_input_model.dart';
import 'custom_text_field.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatefulWidget with DebounceMixin {
  final String? hint;
  final TextInputModel model;
  final Function(String)? onChanged;

  CustomSearchBar({super.key, required this.model, this.onChanged, this.hint});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) => CustomTextField(
    hint: widget.hint ?? widget.model.text,
    label: null,
    inputModel: widget.model,
    prefixWidget: Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 10.w, 0),
      child: Icon(Icons.search_rounded, size: 18.sp, color: AppColors.black),
    ),
    onSubmit: (data) {},
    onChanged: (data) {
      widget.debouncing(fn: () => widget.onChanged?.call(data));
    },
  );
}
