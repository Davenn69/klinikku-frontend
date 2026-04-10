import 'package:klinikku/cores/models/text_input_model.dart';

class RegisterFormModel {
  final TextInputModel name;
  final TextInputModel email;
  final TextInputModel password;

  const RegisterFormModel({
    required this.name,
    required this.email,
    required this.password,
  });
}
