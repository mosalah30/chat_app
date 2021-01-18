

import 'package:base_notifier/base_notifier.dart';
import 'package:chat_app/core/services/api/firebase_api.dart';
import 'package:flutter/material.dart';

import '../../AppTheme.dart';

class ChatHomeScreenModel extends BaseNotifier {
  var firebase = FirebaseApi();
  bool isChecked = false;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(1);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(1);



}