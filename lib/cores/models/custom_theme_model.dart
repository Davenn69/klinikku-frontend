import 'package:flutter/material.dart';

class CustomThemeModel {
  final ThemeData themeData;
  final String name;
  final TabBarIndicatorSize defaultTabBarIndicatorSize;

  const CustomThemeModel({
    required this.themeData,
    required this.name,
    this.defaultTabBarIndicatorSize = TabBarIndicatorSize.tab,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomThemeModel) return false;
    return themeData == other.themeData && name == other.name;
  }

  @override
  int get hashCode => Object.hash(themeData, name);
}
