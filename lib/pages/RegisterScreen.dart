/*
* File : Register
* Version : 1.0.0
* */

import 'dart:math';

import 'package:base_notifier/base_notifier.dart';
import 'package:chat_app/core/page_models/register_screen_page_model.dart';
import 'package:chat_app/routes.dart';
import 'package:chat_app/utils/SizeConfig.dart';
import 'package:chat_app/utils/alert_dialog.dart';
import 'package:chat_app/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../AppTheme.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ThemeData themeData;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    themeData = Theme.of(context);
    return BaseWidget<RegisterScreenModelPage>(
        model: RegisterScreenModelPage(),
        builder: (context, model, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.getThemeFromThemeMode(1),
              home: Scaffold(
                  key: _scaffoldKey,
                  body: Stack(
                    children: <Widget>[
                      ClipPath(
                          clipper: _MyCustomClipper(context),
                          child: Container(
                            alignment: Alignment.center,
                            color: themeData.colorScheme.background,
                          )),
                      Positioned(
                        left: MySize.size30,
                        right: MySize.size30,
                        top: MediaQuery.of(context).size.height * 0.15,
                        child: Column(
                          children: <Widget>[
                            Card(
                              child: Container(
                                padding: EdgeInsets.only(top: MySize.size16, bottom: MySize.size16),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: MySize.size8),
                                      child: Text(
                                        "REGISTER",
                                        style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: MySize.size16, right: MySize.size16, top: MySize.size8),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: MySize.size16),
                                            child: TextFormField(
                                              controller: model.nameTextController,
                                              style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                  color: themeData.colorScheme.onBackground, fontWeight: 500),
                                              decoration: InputDecoration(
                                                hintText: "Name",
                                                hintStyle: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                    color: themeData.colorScheme.onBackground, fontWeight: 500),
                                                prefixIcon: Icon(MdiIcons.accountOutline),
                                              ),
                                              textCapitalization: TextCapitalization.sentences,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: MySize.size16),
                                            child: TextFormField(
                                              controller: model.emailTextController,
                                              style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                  color: themeData.colorScheme.onBackground, fontWeight: 500),
                                              decoration: InputDecoration(
                                                hintText: "Email",
                                                hintStyle: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                    color: themeData.colorScheme.onBackground, fontWeight: 500),
                                                prefixIcon: Icon(MdiIcons.emailOutline),
                                              ),
                                              keyboardType: TextInputType.emailAddress,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: MySize.size16),
                                            child: TextFormField(
                                              controller: model.phoneTextController,
                                              style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                  color: themeData.colorScheme.onBackground, fontWeight: 500),
                                              decoration: InputDecoration(
                                                hintText: "Number",
                                                hintStyle: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                    color: themeData.colorScheme.onBackground, fontWeight: 500),
                                                prefixIcon: Icon(MdiIcons.phoneOutline),
                                              ),
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: MySize.size16),
                                            child: TextFormField(
                                              controller: model.passwordTextController,
                                              style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                  color: themeData.colorScheme.onBackground, fontWeight: 500),
                                              decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                    color: themeData.colorScheme.onBackground, fontWeight: 500),
                                                prefixIcon: Icon(MdiIcons.lockOutline),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: MySize.size16),
                                            child: TextFormField(
                                              controller: model.rePasswordTextController,
                                              style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                  color: themeData.colorScheme.onBackground, fontWeight: 500),
                                              decoration: InputDecoration(
                                                hintText: "RePassword",
                                                hintStyle: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                    color: themeData.colorScheme.onBackground, fontWeight: 500),
                                                prefixIcon: Icon(MdiIcons.lockOutline),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: MySize.size24),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(MySize.size24)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: themeData.colorScheme.primary.withAlpha(28),
                                                    blurRadius: 3,
                                                    offset: Offset(0, 1),
                                                  ),
                                                ],
                                              ),
                                              child: FlatButton(
                                                  padding:
                                                      EdgeInsets.only(left: MySize.size64, right: MySize.size64, top: MySize.size10, bottom: MySize.size10),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MySize.size24)),
                                                  color: themeData.colorScheme.primary,
                                                  splashColor: Colors.white,
                                                  onPressed: () {

                                                    if (model.isValidSignUp(
                                                        name: model.nameTextController.text,
                                                        email: model.emailTextController.text,
                                                        password: model.passwordTextController.text,
                                                        rePassword: model.rePasswordTextController.text,
                                                        phone: model.phoneTextController.text)) {

                                                      showIosProgressDialog(context);

                                                      model.firebase
                                                          .signUpWithEmailAndPassword(
                                                              email: model.emailTextController.text,
                                                              password: model.passwordTextController.text,
                                                              phone: model.phoneTextController.text,
                                                              name: model.nameTextController.text)
                                                          .then((value) {

                                                        Navigator.pop(context);

                                                        if(model.firebase.signErrorMessage.trim().isNotEmpty){
                                                          _scaffoldKey.currentState.showSnackBar(customSnackBar(model.firebase.signErrorMessage, themeData));
                                                        }else{
                                                          AppRoutes.navigateUntil(AppRoutes.chatHomeScreen, context);
                                                        }

                                                      });
                                                    } else {
                                                      _scaffoldKey.currentState.showSnackBar(customSnackBar(model.signUpErrorMessage, themeData));
                                                    }
                                                  },
                                                  child: Text("REGISTER",
                                                      style: AppTheme.getTextStyle(themeData.textTheme.button,
                                                          fontWeight: 600, color: themeData.colorScheme.onPrimary)))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                AppRoutes.navigate(AppRoutes.loginScreen, context);
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: MySize.size16, bottom: MySize.size8),
                                child: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(text: "I've already an Account? ", style: AppTheme.getTextStyle(themeData.textTheme.bodyText2, fontWeight: 500)),
                                    TextSpan(
                                        text: " Login",
                                        style: AppTheme.getTextStyle(themeData.textTheme.bodyText2, fontWeight: 600, color: themeData.colorScheme.primary)),
                                  ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: MySize.size24,
                        left: MySize.size12,
                        child: BackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  )));
        });
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  final BuildContext _context;

  _MyCustomClipper(this._context);

  @override
  Path getClip(Size size) {
    final path = Path();
    Size size = MediaQuery.of(_context).size;
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(0, size.height * 0.6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
