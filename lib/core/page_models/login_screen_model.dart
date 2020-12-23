import 'package:base_notifier/base_notifier.dart';
import 'package:chat_app/core/extensions/string_methods.dart';
import 'package:chat_app/core/services/api/firebase_api.dart';
import 'package:chat_app/core/services/preference/preference.dart';
import 'package:flutter/material.dart';

class LoginScreenModelPage extends BaseNotifier {
  bool passwordVisible = false, isRememberCheck = false;
  var firebaseApi = FirebaseApi();

  String signInErrorMessage = "";


  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  setCheckedBoxValue(bool value) {
    this.isRememberCheck = value;
    notifyListeners();
  }

  isValidSignIn({@required String email, @required String password}) {

    if (email == null || email.isEmpty) {
      signInErrorMessage = "Email is Empty";

      return false;
    }
    if (!StringMethods(email).isEmail()) {
      signInErrorMessage = "you must write Right Email";
      return false;
    }
    if (password == null || password.isEmpty) {
      signInErrorMessage = "password is Empty";
      return false;
    }

    if (password.length < 7) {
      signInErrorMessage = "Password must have more than 8 character";
      return false;
    }

    if (!StringMethods(password).isHaveSmallAndLargeLetter()) {
      signInErrorMessage = "password must have at least  one capital letter and small letter ";
      return false;
    }
    return true;
  }



  saveAccount(bool isSaveAccount) {
    Preference.setBool("saveAccount", isSaveAccount);
  }



  setPasswordVisible() {
    this.passwordVisible = !this.passwordVisible;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
  }
}
