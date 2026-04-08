import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/features/auth/views/login_view.dart';
import 'package:klinikku/features/booking/views/select_appointment_view.dart';
import 'package:klinikku/features/dashboard/views/dashboard_view.dart';
import 'package:klinikku/features/splash/views/splash_view.dart';

late GoRouter _router;
GoRouter get router => _router;
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

setUpRoute({required String initialRoute}) {
  _router = GoRouter(
    navigatorKey: navigatorKey,
    observers: [routeObserver],
    routes: [
      GoRoute(
        path: RouterRoutes.splash.path,
        name: RouterRoutes.splash.name,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: RouterRoutes.login.path,
        name: RouterRoutes.login.name,
        builder: (context, state) => LoginView(),
      ),
      GoRoute(
        path: RouterRoutes.dashboard.path,
        name: RouterRoutes.dashboard.name,
        builder: (context, state) => DashboardView(),
      ),
      GoRoute(
        path: RouterRoutes.selectAppointment.path,
        name: RouterRoutes.selectAppointment.name,
        builder: (context, state) => SelectAppointmentView(),
      ),
    ],
  );
}
