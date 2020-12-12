import 'package:chat_app/pages/LoginScreen.dart';
import 'package:chat_app/pages/RegisterScreen.dart';
import 'package:chat_app/pages/chat_home_Page/ChatHomeScreen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Widget get chatHomeScreen => ChatHomeScreen();

  static Widget get registerScreen => RegisterScreen();

  static Widget get loginScreen => LoginScreen();

  static navigate(Widget widget, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  static navigateUntil(Widget widget, BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget), (Route<dynamic> route) => false);
  }
}
