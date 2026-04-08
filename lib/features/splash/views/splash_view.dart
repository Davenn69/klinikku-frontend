import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/utils/hive_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Future.delayed(Duration(seconds: 3), () async {
        ctx.pushReplacementNamed(RouterRoutes.login.name);
        // if (Supabase.instance.client.auth.currentSession != null) {
        //   try {
        //     final response =
        //         await Supabase.instance.client.auth.refreshSession();

        //     if (response.session != null &&
        //         response.session!.accessToken.isNotEmpty) {
        //       ctx.pushReplacementNamed(RouterRoutes.dashboard.name);
        //     } else {
        //       ctx.pushReplacementNamed(RouterRoutes.login.name);
        //     }
        //   } catch (e) {
        //     print('refresh session error: $e');
        //     await HiveHelper.clearSession();
        //     ctx.pushReplacementNamed(RouterRoutes.login.name);
        //   }
        // } else {
        //   ctx.pushReplacementNamed(RouterRoutes.login.name);
        // }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    color: AppColors.primary,
    child: Center(
      child: Text(
        'KlinikKu',
        style: textTheme.headline1.copyWith(fontSize: 32.sp),
      ),
    ),
  );
}
