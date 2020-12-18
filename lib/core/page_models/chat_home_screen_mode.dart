

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';

import '../../AppTheme.dart';

class ChatHomeScreenModel extends BaseNotifier {
  bool isChecked = false;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(1);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(1);

  someFunction() async {
    await Future.delayed(Duration(seconds: 5));
  }
}