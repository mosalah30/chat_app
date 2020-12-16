import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';

import '../../AppTheme.dart';

class LoginScreenModelPage extends BaseNotifier {
  bool passwordVisible = false, check = false;

  setCheckedBoxValue(bool value) {
    this.check = value;
    notifyListeners();
  }

  setPasswordVisible() {
    this.passwordVisible = !this.passwordVisible;
    notifyListeners();
  }


}
