import 'package:final_project/core/extension/context.dart';
import 'package:flutter/material.dart';

mixin RegistrationValidate {
  String? validateEmail({
    required BuildContext context,
    required String? email,
  }) {
    RegExp expEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email?.isEmpty ?? true) {
      return context.lang.empty(context.lang.email);
    } else if (!expEmail.hasMatch(email!)) {
      return context.lang.formateEmail;
    } else {
      return null;
    }
  }

  String? validateIsEmpty(
      {required BuildContext context,
      required String? value,
      required String textFelidName}) {
    if (value?.isEmpty ?? true) {
      return context.lang.empty(textFelidName);
    }
    return null;
  }

  String? validatePassword({
    required BuildContext context,
    required String? password,
  }) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExpPassword = RegExp(pattern);
    if (password?.isEmpty ?? true) {
      return context.lang.empty(context.lang.password);
    } else if (!regExpPassword.hasMatch(password!)) {
      return context.lang.formatePassword;
    } else {
      return null;
    }
  }
}
