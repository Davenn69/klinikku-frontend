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
import 'package:klinikku/features/auth/models/register_form_model.dart';
import 'package:klinikku/features/auth/services/register_services.dart';

class RegisterVM extends BaseFormNotifier<RegisterFormModel>
    with FormValidatorMixin, ToastMixin {
  @override
  late RegisterFormModel form;

  final _service = RegisterServices();

  RegisterVM(super.ref);

  @override
  FutureOr<void> init() {
    form = RegisterFormModel(
      name: TextInputModel(
        validator:
            (value) => getValidation(
              value: value,
              label: 'Nama',
              validationList: [Validator.name],
            ),
      ),
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

  register() async {
    if (!validate()) return;
    isLoading = true;
    var response = await _service.register(
      form.name.text,
      form.email.text,
      form.password.text,
    );
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
