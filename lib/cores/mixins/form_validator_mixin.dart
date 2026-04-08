import 'package:klinikku/cores/bases/base_notifier.dart';

mixin FormValidatorMixin on BaseNotifier {
  final RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$');

  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$',
  );

  String? getValidation({
    required String value,
    required String label,
    required List<Validator> validationList,
    String? confirmValue,
    List<String>? confirmList,
    Function()? setPhoneBorderError,
    bool isRequired = true,
  }) {
    // Empty validation
    if (value.isEmpty && isRequired) {
      if (setPhoneBorderError != null) {
        setPhoneBorderError();
      }
      return '$label can\'t be empty';
    }

    // Length / 8 Characters validation
    if (validationList.contains(Validator.length) && value.length < 8) {
      return '$label is less than 8 characters';
    }

    // Email validation
    if (validationList.contains(Validator.emailFormat) &&
        !emailRegex.hasMatch(value)) {
      return 'Email format is incorrect';
    }

    // Password validation
    if (validationList.contains(Validator.passwordFormat) &&
        !passwordRegex.hasMatch(value)) {
      return 'Password should follow these formats:\n'
          '- At least 6 charactes\n'
          '- At least 1 uppercase letter\n'
          '- At least 1 lowercase letter\n'
          '- At least 1 number';
    }

    // Confirm Password validation
    if (validationList.contains(Validator.confirmPassword) &&
        ((confirmValue ?? '').isEmpty || value != (confirmValue ?? ''))) {
      return 'Password doesn\'t match';
    }

    return null;
  }
}

enum Validator { length, emailFormat, passwordFormat, confirmPassword }
