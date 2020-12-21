import 'package:base_notifier/base_notifier.dart';
import 'package:chat_app/core/extensions/string_methods.dart';
import 'package:chat_app/core/services/api/firebase_api.dart';
import 'package:chat_app/core/services/preference/preference.dart';
import 'package:flutter/material.dart';

class LoginScreenModelPage extends BaseNotifier {
  bool passwordVisible = false, isRememberCheck = false, isEmailValid = false, isPasswordValid = false;
  var firebaseApi = FirebaseApi();

  String emailErrorMessage = "";
  String passwordErrorMessage = "";

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  setCheckedBoxValue(bool value) {
    this.isRememberCheck = value;
    notifyListeners();
  }

  validEmail(String email) {
    if (email == null || email.isEmpty) {
      emailErrorMessage = "Email is Empty";

      return false;
    }
    if (!StringMethods(email).isEmail()) {
      emailErrorMessage = "you must write Right Email";
      return false;
    }
    isEmailValid = true;
    return isEmailValid;
  }

  saveAccount(bool isSaveAccount) {
    Preference.setBool("saveAccount", isSaveAccount);
  }

  validPassword(String password) {
    isPasswordValid = StringMethods(password).isPassword();

    if (password == null || password.isEmpty) {
      passwordErrorMessage = "password is Empty";
      return false;
    }

    if (password.length < 7) {
      passwordErrorMessage = "Password must have more than 8 character";
      return false;
    }

    if (!StringMethods(password).isHaveSmallAndLargeLetter()) {
      passwordErrorMessage = "password must have at least  one capital letter and small letter ";
      return false;
    }
    isPasswordValid = true;
    return isPasswordValid;
  }

  setPasswordVisible() {
    this.passwordVisible = !this.passwordVisible;
  }

  @override
  void dispose() {
    super.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
  }
}
