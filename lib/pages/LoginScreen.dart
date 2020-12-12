/*
* File : Login
* Version : 1.0.0
* */


import 'package:chat_app/utils/MeasureSize.dart';
import 'package:chat_app/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../AppTheme.dart';
import '../routes.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false, _check = false;
  ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData=AppTheme.getThemeFromThemeMode();
    MySize().init(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getThemeFromThemeMode(1),
        home: Scaffold(
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
                  top: MediaQuery.of(context).size.height * 0.2,
                  child: MeasureSize(
                    onChange: (Size size) {
                      print(size);
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Card(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: MySize.size16, bottom: MySize.size16),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: MySize.size24, top: MySize.size8),
                                  child: Text(
                                    "LOGIN",
                                    style: AppTheme.getTextStyle(
                                        themeData.textTheme.headline6,
                                        fontWeight: 600),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MySize.size16,
                                      right: MySize.size16),
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText1,
                                            letterSpacing: 0.1,
                                            color: themeData
                                                .colorScheme.onBackground,
                                            fontWeight: 500),
                                        decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle: AppTheme.getTextStyle(
                                              themeData.textTheme.subtitle2,
                                              letterSpacing: 0.1,
                                              color: themeData
                                                  .colorScheme.onBackground,
                                              fontWeight: 500),
                                          prefixIcon:
                                          Icon(MdiIcons.emailOutline),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: MySize.size16),
                                        child: TextFormField(
                                          style: AppTheme.getTextStyle(
                                              themeData.textTheme.bodyText1,
                                              letterSpacing: 0.1,
                                              color: themeData
                                                  .colorScheme.onBackground,
                                              fontWeight: 500),
                                          decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle: AppTheme.getTextStyle(
                                                themeData.textTheme.subtitle2,
                                                letterSpacing: 0.1,
                                                color: themeData
                                                    .colorScheme.onBackground,
                                                fontWeight: 500),
                                            prefixIcon:
                                            Icon(MdiIcons.lockOutline),
                                            suffixIcon: IconButton(
                                              icon: Icon(_passwordVisible
                                                  ? MdiIcons.eyeOutline
                                                  : MdiIcons.eyeOffOutline),
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisible =
                                                  !_passwordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                          obscureText: _passwordVisible,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: MySize.size16),
                                        alignment: Alignment.centerRight,
                                        child: Text("Forgot Password?",
                                            style: AppTheme.getTextStyle(
                                                themeData.textTheme.bodyText2,
                                                fontWeight: 500)),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            Checkbox(
                                              activeColor:
                                              themeData.colorScheme.primary,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _check = value;
                                                });
                                              },
                                              value: _check,
                                              visualDensity:
                                              VisualDensity.compact,
                                            ),
                                            Text(
                                              "Remember me",
                                              style: themeData
                                                  .textTheme.bodyText2
                                                  .merge(TextStyle(
                                                  color: themeData
                                                      .colorScheme
                                                      .onBackground)),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(top: MySize.size16),
                                        width:
                                        MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(MySize.size24)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: themeData
                                                  .colorScheme.primary
                                                  .withAlpha(18),
                                              blurRadius: 3,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: FlatButton(
                                            padding: EdgeInsets.only(
                                                top: MySize.size10,
                                                bottom: MySize.size10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(24)),
                                            color:
                                            themeData.colorScheme.primary,
                                            splashColor: Colors.white,
                                            onPressed: () {},
                                            child: Text("LOGIN",
                                                style: AppTheme.getTextStyle(
                                                    themeData.textTheme.button,
                                                    fontWeight: 600,
                                                    color: themeData
                                                        .colorScheme.onPrimary,
                                                    letterSpacing: 0.5))),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: MySize.size16),
                                        child: Center(
                                          child: Text(
                                            "OR",
                                            style: AppTheme.getTextStyle(
                                                themeData.textTheme.bodyText2,
                                                fontWeight: 500),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(MySize.size24)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: themeData
                                                  .colorScheme.primary
                                                  .withAlpha(18),
                                              blurRadius: 3,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: FlatButton(
                                            padding: EdgeInsets.only(
                                                top: MySize.size10,
                                                bottom: MySize.size10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    MySize.size20)),
                                            color:
                                            themeData.colorScheme.primary,
                                            splashColor: Colors.white,
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  "Login with Google",
                                                  style: AppTheme.getTextStyle(
                                                      themeData
                                                          .textTheme.bodyText1,
                                                      fontWeight: 600,
                                                      color: themeData
                                                          .colorScheme
                                                          .onPrimary,
                                                      letterSpacing: 0.3),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            AppRoutes.navigate       (AppRoutes.registerScreen, context);

                          },
                          child: Container(
                            margin: EdgeInsets.only(top: MySize.size16),
                            child: Center(
                              child: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "Don't have an Account? ",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 500)),
                                  TextSpan(
                                      text: " Register",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color:
                                          themeData.colorScheme.primary)),
                                ]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //   top: 24,
                //   left: 12,
                //   child: BackButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     color: themeData.colorScheme.onBackground,
                //   ),
                // )
              ],
            )));
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
