import 'package:flutter/material.dart';

class DashboardQuickAction {
  final String title;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final void Function() onTap;

  const DashboardQuickAction({
    required this.title,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.onTap,
  });
}
