import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klinikku/cores/constants/custom_theme.dart';
import 'package:klinikku/cores/router/router.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );

      await ScreenUtil.ensureScreenSize();

      await setUpRoute(initialRoute: '/');

      runApp(const Klinikku());
    },
    (error, stack) {
      print(error);
      print(stack);
    },
  );
}

class Klinikku extends StatefulWidget {
  const Klinikku({super.key});

  @override
  State<Klinikku> createState() => _KlinikkuState();
}

class _KlinikkuState extends State<Klinikku> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 768),
      minTextAdapt: true,
    );
    return ProviderScope(
      child: OKToast(
        child: MaterialApp.router(
          routerConfig: router,
          theme: CustomTheme.lightTheme.themeData,
          title: 'Klinikku',
          builder:
              (_, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(boldText: false),
                child: MediaQuery.withNoTextScaling(child: child!),
              ),
        ),
      ),
    );
  }
}
