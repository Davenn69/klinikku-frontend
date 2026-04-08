import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/features/auth/views/login_view.dart';

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
        builder: (context, state) => LoginView(),
      ),
    ],
  );
}
