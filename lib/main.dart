import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:klinikku/cores/configs/env.dart';
import 'package:klinikku/cores/configs/flavor_config.dart';
import 'package:klinikku/cores/constants/custom_theme.dart';
import 'package:klinikku/cores/router/router.dart';
import 'package:klinikku/cores/utils/hive_helper.dart';
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

      await initialHiveSetup();
      await ScreenUtil.ensureScreenSize();

      const flavor = String.fromEnvironment('ENV');
      setupConfig(flavor);

      await setUpRoute(initialRoute: '/login');

      runApp(const Klinikku());
    },
    (error, stack) {
      print(error);
      print(stack);
    },
  );
}

void setupConfig(String flavor) {
  FlavorConfig(
    flavor: convertToFlavorEnum(flavor),
    values:
        flavor == 'staging'
            ? FlavorValues(
              baseUrl: EnvStage.baseUrl,
              showBanner: EnvStage.showBanner,
            )
            : FlavorValues(
              baseUrl: EnvProd.baseUrl,
              showBanner: EnvProd.showBanner,
            ),
  );
}

initialHiveSetup() async {
  try {
    await Hive.initFlutter();
    await HiveHelper.openBoxes();
  } catch (e) {
    print('hive setup error $e');
  }
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
