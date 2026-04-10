import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:klinikku/cores/bases/base_view.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/widgets/custom_dropdown.dart';
import 'package:klinikku/features/booking/models/doctor_model.dart';
import 'package:klinikku/features/booking/models/region_model.dart';
import 'package:klinikku/features/booking/viewmodels/select_appointment_viewmodel.dart';
import 'package:klinikku/features/booking/widgets/day_tile.dart';
import 'package:klinikku/features/booking/widgets/slot_card.dart';

class SelectAppointmentView extends StatelessWidget {
  const SelectAppointmentView({super.key});

  @override
  Widget build(BuildContext context) =>
      BaseView(provider: selectAppointmentVm, builder: _buildScreen);

  Widget _buildScreen(BuildContext context, SelectAppointmentVM vm) => SafeArea(
    bottom: false,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropdownButton<RegionModel>(
                  options: vm.regions,
                  hint: 'Pilih region',
                  label: 'REGION',
                  inputModel: vm.form.region,
                  getLabel: (value) => value?.name ?? '',
                  onValueChanged: (data) => vm.onRegionChanged(data.id),
                ),
                Gap(16.h),
                CustomDropdownButton<DoctorModel>(
                  options: vm.doctors,
                  hint: 'Pilih dokter',
                  isDisabled: vm.form.region.selectedValue == null,
                  label: 'DOKTER',
                  inputModel: vm.form.doctor,
                  getLabel: (value) => value?.name ?? '',
                  onValueChanged: (data) => vm.onDoctorChanged(data),
                ),
                Gap(16.h),
                Text(
                  'TANGGAL',
                  style: textTheme.caption1.copyWith(fontSize: 14.sp),
                ),
                Gap(8.h),
                SizedBox(
                  height: 58.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: vm.availableDays.length,
                    separatorBuilder: (_, __) => Gap(10.w),
                    itemBuilder: (context, index) {
                      final day = vm.availableDays[index];
                      final isSelected = vm.selectedDayIndex == index;
                      return DayTile(
                        dayNumber: day.dayNumber,
                        dayLabel: day.dayLabel,
                        isSelected: isSelected,
                        onTap: () => vm.selectDay(index),
                      );
                    },
                  ),
                ),
                Gap(16.h),
                if (vm.slots.isEmpty)
                  if (vm.form.doctor.selectedValue != null &&
                      vm.form.region.selectedValue != null &&
                      vm.form.date.selectedValue != null) ...[
                    _buildEmptyState(),
                  ] else
                    ...[]
                else ...[
                  Text(
                    'Menampilkan ${vm.slots.length} slot untuk ${vm.selectedDateText}',
                    style: textTheme.body6.copyWith(color: AppColors.gray1),
                  ),
                  Gap(8.h),
                  Column(
                    children:
                        vm.slots.map((slot) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: SlotCard(
                              slot: slot,
                              doctorSpecialization:
                                  vm
                                      .form
                                      .doctor
                                      .selectedValue
                                      ?.specialization ??
                                  '',
                              onTap:
                                  slot.isAvailable
                                      ? () => vm.onSlotTap(slot)
                                      : null,
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildHeader(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 26.h),
    decoration: const BoxDecoration(color: AppColors.primary),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).maybePop(),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.white,
                  size: 20.sp,
                ),
                Gap(6.w),
                Text(
                  'Kembali',
                  style: textTheme.body6.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(16.h),
        Text(
          'Cari Slot Appointment',
          style: textTheme.headline1.copyWith(
            color: AppColors.white,
            height: 1.1,
          ),
        ),
      ],
    ),
  );

  Widget _buildEmptyState() => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 18.w),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: AppColors.gray2),
    ),
    child: Column(
      children: [
        Icon(Icons.event_busy_outlined, size: 34.sp, color: AppColors.gray1),
        Gap(10.h),
        Text(
          'Belum ada slot tersedia',
          style: textTheme.body5.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        Gap(4.h),
        Text(
          'Silakan coba tanggal lain atau cek kembali nanti.',
          style: textTheme.body6.copyWith(color: AppColors.gray1),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
