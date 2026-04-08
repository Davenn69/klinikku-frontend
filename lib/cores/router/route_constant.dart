import 'package:flutter/material.dart';

class RouterRoute {
  final String path;
  final String name;

  const RouterRoute({required this.path, required this.name});
}

class RouterRoutes {
  static const splash = RouterRoute(path: '/', name: 'splash');
  static const login = RouterRoute(path: '/login', name: 'login');
  static const dashboard = RouterRoute(path: '/dashboard', name: 'dashboard');
  static const selectAppointment = RouterRoute(
    path: '/selectAppointment',
    name: 'selectAppointment',
  );
  static const bookingConfirmation = RouterRoute(
    path: '/bookingConfirmation',
    name: 'bookingConfirmation',
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext get ctx => navigatorKey.currentContext!;
