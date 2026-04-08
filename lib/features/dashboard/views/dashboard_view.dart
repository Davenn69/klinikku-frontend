import 'package:flutter/material.dart';
import 'package:klinikku/cores/bases/base_view.dart';
import 'package:klinikku/features/dashboard/viewmodels/dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) =>
      BaseView(provider: dashboardVM, builder: _buildScreen);

  Widget _buildScreen(BuildContext context, DashboardVM vm) =>
      SingleChildScrollView(child: Column(children: []));
}
