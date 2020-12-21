import 'dart:io';

import 'package:chat_app/core/models/api_models.dart';
import 'package:chat_app/core/services/preference/preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseApi {
  static const users = "Users";
  static const profile = "Profile";
  String signErrorMessage = "";

  static final FirebaseApi _singleton = FirebaseApi._internal();

  factory FirebaseApi() {
    return _singleton;
  }

  FirebaseApi._internal();

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  auth.FirebaseUser firebaseUser;

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;


  Future signInWithEmailAndPassword({@required String email, @required String password, @required bool isRemember}) async {
    try {
      signErrorMessage = "";
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser = userCredential.user;
      await saveProfilePreference(userCredential, isRemember);
    } catch (e) {
      if (Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            signErrorMessage = "User Not Found";
            break;
          case 'The password is invalid or the user does not have a password.':
            signErrorMessage = "Password Not Valid";
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            signErrorMessage = "Network Error";
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      } else if (Platform.isIOS) {
        switch (e.code) {
          case 'Error 17011':
            signErrorMessage = "User Not Found";
            break;
          case 'Error 17009':
            signErrorMessage = "Password Not Valid";
            break;
          case 'Error 17020':
            signErrorMessage = "Network Error";
            break;
          // ...
          default:
            signErrorMessage = '${e.message}';
        }
      }
    }
  }

  Future<void> signUpWithEmailAndPassword({@required String email, @required String password, @required String phone, @required String name}) async {
    try {
      signErrorMessage = "";
      auth.UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await saveProfileToFireStore(name: name, email: email, phone: phone, id: userCredential.user.uid);
      await saveProfilePreference(userCredential);
    } catch (e) {
      switch (e) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          signErrorMessage = "This e-mail address is already in use, please use a different e-mail address.";
          break;
        case 'ERROR_INVALID_EMAIL':
          signErrorMessage = "The email address is badly formatted.";
          break;

        case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
          signErrorMessage =
              "The e-mail address in your Facebook account has been registered in the system before. Please login by trying other methods with this e-mail address.";
          break;

        case 'ERROR_WRONG_PASSWORD':
          signErrorMessage = "E-mail address or password is incorrect.";
          break;

        default:
          signErrorMessage = "${e.message}";
      }
    }
  }

  Future saveProfilePreference(auth.UserCredential userCredential, [bool isRemember = false]) async {
    await Preference.setString(PrefKeys.token, userCredential.user.uid);
    await Preference.setBool(PrefKeys.userLogged, true);
    await Preference.setBool(PrefKeys.isRemember, true);
  }

  saveProfileToFireStore({@required String name, @required String email, @required String phone, @required id}) {
    _firebaseFireStore.collection(users).add(
          User(name: name, email: email, id: id, phone: phone).toMap(),
        );
  }

  Future userLogOut() async {
    await Preference.clear();
    await _firebaseAuth.signOut();
  }

 Future signWithGoogle({@required Function function ,bool isRemember}) async {
    try {
      signErrorMessage = "";
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      var userCredential = await _firebaseAuth.signInWithCredential(credential);
      function.call();
      await saveProfileToFireStore(
          name: userCredential.user.displayName, email: userCredential.user.email, phone: userCredential.user.phoneNumber, id: userCredential.user.uid);
      await saveProfilePreference(userCredential, isRemember);
    } catch (e) {
      signErrorMessage = " ${e.message}";
    }
  }
}
