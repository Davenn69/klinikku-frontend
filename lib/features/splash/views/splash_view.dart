import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/configs/flavor_config.dart';
import 'package:klinikku/cores/constants/colors.dart';
import 'package:klinikku/cores/constants/text_theme.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/utils/hive_helper.dart';
import 'package:klinikku/features/splash/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with ToastMixin {
  final _service = SplashServices();

  Future<Map<String, String>?> getNewToken(String refreshToken) async {
    final response = await _service.refresh(refreshToken);

    if (response is DioException) {
      String errorMsg =
          response.response == null
              ? "Internal server error."
              : response.response!.data['error']['message'];
      showErrorToast(errorMsg);
      return null;
    }

    String accessTokens = response.data['accessToken'];
    String refreshTokens = response.data['refreshToken'];

    await HiveHelper.saveSessionTokens(
      accessToken: accessTokens,
      refreshToken: refreshTokens,
    );

    FlavorConfig.instance!.values.token = accessTokens;

    return {'accessToken': accessTokens, 'refreshToken': refreshTokens};
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Future.delayed(Duration(seconds: 3), () async {
        String? accessToken = await HiveHelper.getAccessToken();
        String? refreshToken = await HiveHelper.getRefreshToken();
        if (accessToken != null && refreshToken != null) {
          try {
            final response = await getNewToken(refreshToken);

            if (response != null) {
              ctx.pushReplacementNamed(RouterRoutes.dashboard.name);
            } else {
              ctx.pushReplacementNamed(RouterRoutes.login.name);
            }
          } catch (e) {
            print('refresh session error: $e');
            await HiveHelper.clearSession();
            ctx.pushReplacementNamed(RouterRoutes.login.name);
          }
        } else {
          ctx.pushReplacementNamed(RouterRoutes.login.name);
        }
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
