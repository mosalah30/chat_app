import 'package:base_notifier/base_notifier.dart';
import 'package:chat_app/core/extensions/string_methods.dart';
import 'package:chat_app/core/services/preference/preference.dart';
import 'package:flutter/material.dart';

import '../../AppTheme.dart';

class LoginScreenModelPage extends BaseNotifier {
  bool passwordVisible = false, check = false;

  setCheckedBoxValue(bool value) {
    this.check = value;
    notifyListeners();
  }

  validEmail(String email) {
    bool isTrue = StringMethods(email).isEmail();
    notifyListeners();
    return isTrue;
  }

  saveAccount(bool isSaveAccount) {
    Preference.setBool("saveAccount", isSaveAccount);
  }

  validPassword(String password) {
    bool isTrue = StringMethods(password).isPassword();
    return isTrue;
  }

  setPasswordVisible() {
    this.passwordVisible = !this.passwordVisible;
  }
}
