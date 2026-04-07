import 'package:flutter/material.dart';

import '../utils/string_extension.dart';

enum Flavor { staging, production }

convertToFlavorEnum(String value) {
  switch (value) {
    case 'production':
      return Flavor.production;
    default:
      return Flavor.staging;
  }
}

class FlavorValues {
  final String apiUrl;
  final bool showBanner;

  FlavorValues({required this.apiUrl, this.showBanner = false});

  String token = 'ab';
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;
  final Color color;

  static FlavorConfig? get instance => _instance;

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);

  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues values,
    Color color = Colors.blue,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor,
      flavor.toString().enumName(),
      color,
      values,
    );
    return _instance!;
  }

  /// If show banner, return [true]
  static bool showBanner() => _instance!.values.showBanner;
}
