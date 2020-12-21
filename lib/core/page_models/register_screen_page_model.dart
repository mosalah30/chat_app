import 'package:base_notifier/base_notifier.dart';
import 'package:chat_app/core/services/api/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/extensions/string_methods.dart';

class RegisterScreenModelPage extends BaseNotifier {
  String signUpErrorMessage = "";
  var firebase = FirebaseApi();

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final rePasswordTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  isValidSignUp({@required String name, @required String email, @required String password, @required String rePassword, @required String phone}) {
    if (name == null || name.trim().isEmpty) {
      signUpErrorMessage = "Name is Empty";
      return false;
    }

    if (email == null || email.trim().isEmpty) {
      signUpErrorMessage = "Email is Empty";

      return false;
    }
    if (!StringMethods(email).isEmail()) {
      signUpErrorMessage = "you must write Right Email";
      return false;
    }
    if (phone == null || phone.trim().isEmpty) {
      signUpErrorMessage = " number phone is Empty";
      return false;
    }

    if (phone.length < 10) {
      signUpErrorMessage = "Number Phone  must be  11 numbers";
      return false;
    }

    if (password == null || password.trim().isEmpty) {
      signUpErrorMessage = "password is Empty";
      return false;
    }

    if (password.length < 7) {
      signUpErrorMessage = "Password must have more than 8 character";
      return false;
    }

    if (!StringMethods(password).isHaveSmallAndLargeLetter()) {
      signUpErrorMessage = "password must have at least  one capital letter and small letter ";
      return false;
    }

    if (rePassword == null || rePassword.trim().isEmpty) {
      signUpErrorMessage = "RePassword is Empty";
      return false;
    }

    if (password!=rePassword) {
      signUpErrorMessage = "password must equal RePassword";
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTextController.dispose();
    emailTextController.dispose();
    phoneTextController.dispose();
    passwordTextController.dispose();
    rePasswordTextController.dispose();

  }
}
