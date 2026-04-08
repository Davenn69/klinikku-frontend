import 'package:flutter/material.dart';
import 'package:klinikku/cores/bases/base_view.dart';
import 'package:klinikku/features/booking/viewmodels/select_appointment_viewmodel.dart';

class SelectAppointmentView extends StatelessWidget {
  const SelectAppointmentView({super.key});

  @override
  Widget build(BuildContext context) =>
      BaseView(provider: selectAppointmentVm, builder: _buildScreen);

  Widget _buildScreen(BuildContext context, SelectAppointmentVM vm) =>
      Container();
}
