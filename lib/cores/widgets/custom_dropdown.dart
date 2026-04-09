import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/models/text_input_model.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/widgets/custom_search_bar.dart';
import 'package:klinikku/cores/widgets/tap_detector.dart';
import '../models/selection_input_model.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  final SelectionInputModel<T> inputModel;
  final List<T> options;
  final String hint;
  final String label;
  final String Function(T?) getLabel;
  final Function(T)? onValueChanged;
  final bool isSearchable;
  final bool showDragHandle;
  final bool isDisabled;

  const CustomDropdownButton({
    super.key,
    required this.options,
    required this.hint,
    required this.label,
    required this.inputModel,
    required this.getLabel,
    this.onValueChanged,
    this.isSearchable = false,
    this.showDragHandle = true,
    this.isDisabled = false,
  });

  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  final TextInputModel model = TextInputModel();
  late String? selectedValue;
  String? errorMessage;
  String filter = '';
  int? _initialOptionCount;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.getLabel(widget.inputModel.selectedValue);
  }

  @override
  void didUpdateWidget(covariant CustomDropdownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.inputModel.errorMessage != null) {
      setState(() {
        errorMessage = widget.inputModel.errorMessage;
      });
    }

    if (widget.inputModel.selectedValue == null) {
      setState(() {
        selectedValue = '';
      });
    }
  }

  Widget _searchableOption() => ListView(
    shrinkWrap: false,
    children:
        widget.options
            .asMap()
            .entries
            .where((entry) {
              final option = entry.value;
              final data = widget.getLabel(option).toLowerCase();
              return data.contains(filter.toLowerCase());
            })
            .map((entry) {
              final option = entry.value;
              return TapDetector(
                onTap: () {
                  setState(() {
                    widget.inputModel.selectedValue = option;
                    widget.inputModel.errorMessage = null;
                    errorMessage = null;
                    selectedValue = widget.getLabel(option);
                  });
                  widget.onValueChanged?.call(option);
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                  decoration: BoxDecoration(color: AppColors.transparent),
                  child: Text(widget.getLabel(option), style: textTheme.body6),
                ),
              );
            })
            .toList(),
  );

  Widget _nonSearchableOption() => Container(
    padding: EdgeInsets.only(top: 0),
    width: double.infinity,
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(ctx).size.height * 0.5,
      ),
      child: SingleChildScrollView(
        child: Column(
          children:
              widget.options
                  .asMap()
                  .entries
                  .where((entry) {
                    final option = entry.value;
                    final data = widget.getLabel(option).toLowerCase();

                    return data.contains(filter.toLowerCase());
                  })
                  .map((entry) {
                    final option = entry.value;
                    return TapDetector(
                      onTap: () {
                        setState(() {
                          widget.inputModel.selectedValue = option;
                          widget.inputModel.errorMessage = null;
                          errorMessage = null;
                          selectedValue = widget.getLabel(option);
                        });
                        widget.onValueChanged?.call(option);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                        decoration: BoxDecoration(color: AppColors.transparent),
                        child: Text(
                          widget.getLabel(option),
                          style: textTheme.body6,
                        ),
                      ),
                    );
                  })
                  .toList(),
        ),
      ),
    ),
  );

  void _showOption(BuildContext context) => showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.6,
    ),
    backgroundColor: AppColors.white,
    showDragHandle: widget.showDragHandle,
    builder:
        (_) => StatefulBuilder(
          builder:
              (_, modalSetState) => SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!widget.showDragHandle) Gap(16.h),
                    if (widget.isSearchable) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: CustomSearchBar(
                          hint: widget.hint,
                          model: model,
                          onChanged: (data) {
                            modalSetState(() {
                              filter = data;
                            });
                          },
                        ),
                      ),
                      Gap(16.h),
                      Expanded(child: _searchableOption()),
                    ],
                    if (!widget.isSearchable) ...[
                      if (widget.options.length >= 10) ...[
                        Expanded(child: _nonSearchableOption()),
                      ] else ...[
                        _nonSearchableOption(),
                      ],
                    ],
                  ],
                ),
              ),
        ),
  );

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      if (widget.label.isNotEmpty) ...[
        Text.rich(
          TextSpan(
            style: textTheme.caption1,
            children: [TextSpan(text: widget.label.toUpperCase())],
          ),
        ),
        Gap(6.h),
      ],
      TapDetector(
        onTap:
            widget.isDisabled
                ? null
                : () {
                  FocusScope.of(context).requestFocus(FocusNode());

                  _showOption(context);
                },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: errorMessage != null ? AppColors.warning : AppColors.gray2,
              width: 1,
            ),
            color: widget.isDisabled ? AppColors.gray2 : AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedValue!.isEmpty ? widget.hint : selectedValue!,
                style:
                    widget.isDisabled
                        ? textTheme.body6.copyWith(color: AppColors.gray1)
                        : selectedValue!.isEmpty
                        ? textTheme.body6.copyWith(color: AppColors.gray1)
                        : textTheme.body6.copyWith(
                          color:
                              errorMessage != null
                                  ? AppColors.warning
                                  : AppColors.black,
                        ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.gray1,
                    size: 24.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      if (errorMessage != null) ...[
        Gap(3.h),
        Text(
          errorMessage ?? '',
          style: textTheme.body6.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.warning,
          ),
        ),
      ],
    ],
  );
}
