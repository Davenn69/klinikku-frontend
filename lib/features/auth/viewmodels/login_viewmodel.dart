import 'dart:async';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:klinikku/cores/bases/base_form_notifier.dart';
import 'package:klinikku/cores/configs/flavor_config.dart';
import 'package:klinikku/cores/mixins/form_validator_mixin.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/cores/models/text_input_model.dart';
import 'package:klinikku/cores/router/route_constant.dart';
import 'package:klinikku/cores/utils/hive_helper.dart';
import 'package:klinikku/features/auth/models/login_form_model.dart';
import 'package:klinikku/features/auth/services/login_services.dart';

class LoginVM extends BaseFormNotifier<LoginFormModel>
    with FormValidatorMixin, ToastMixin {
  @override
  late LoginFormModel form;

  final _service = LoginServices();

  LoginVM(super.ref);

  @override
  FutureOr<void> init() {
    form = LoginFormModel(
      email: TextInputModel(
        validator:
            (value) => getValidation(
              value: value,
              label: 'Email',
              validationList: [Validator.emailFormat],
            ),
      ),
      password: TextInputModel(
        validator:
            (value) => getValidation(
              value: value,
              label: 'Password',
              validationList: [Validator.passwordFormat],
            ),
      ),
    );
  }

  login() async {
    if (!validate()) return;
    isLoading = true;
    var response = await _service.login(form.email.text, form.password.text);
    isLoading = false;
    if (response is DioException) {
      String errorMsg =
          response.response == null
              ? "Internal server error."
              : response.response!.data['error']['message'];
      showErrorToast(errorMsg);
      return;
    }

    final data = response.data;
    await HiveHelper.saveSessionTokens(
      accessToken: data['accessToken'],
      refreshToken: data['refreshToken'],
    );
    FlavorConfig.instance!.values.token = data['accessToken'];

    ctx.pushReplacementNamed(RouterRoutes.dashboard.name);
  }
}
