import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/features/auth/views/login_view.dart';
import 'package:klinikku/features/booking/models/appointment_slot_item.dart';
import 'package:klinikku/features/booking/models/booking_confirmation_model.dart';
import 'package:klinikku/features/booking/models/doctor_model.dart';
import 'package:klinikku/features/booking/models/region_model.dart';
import 'package:klinikku/features/booking/views/booking_confirmation_view.dart';
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
      GoRoute(
        path: RouterRoutes.bookingConfirmation.path,
        name: RouterRoutes.bookingConfirmation.name,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final RegionModel region = data['region'];
          final DoctorModel doctor = data['doctor'];
          final AppointmentSlotItem appointment = data['appointment'];

          return BookingConfirmationView(
            data: BookingConfirmationModel(
              doctor: doctor,
              region: region,
              appointment: appointment,
            ),
          );
        },
      ),
    ],
  );
}
