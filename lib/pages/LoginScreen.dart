import 'package:base_notifier/base_notifier.dart';
import 'package:chat_app/core/page_models/login_screen_model.dart';
import 'package:chat_app/core/services/preference/preference.dart';
import 'package:chat_app/utils/MeasureSize.dart';
import 'package:chat_app/utils/SizeConfig.dart';
import 'package:chat_app/utils/alert_dialog.dart';
import 'package:chat_app/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../AppTheme.dart';
import '../routes.dart';

class LoginScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = AppTheme.getThemeFromThemeMode();
    MySize().init(context);

    return BaseWidget<LoginScreenModelPage>(
      model: LoginScreenModelPage(),
      initState: (m) {
        m.isLoginBefore(context);
      },
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
                                padding: EdgeInsets.only(top: MySize.size16, bottom: MySize.size16),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(bottom: MySize.size24, top: MySize.size8),
                                      child: Text(
                                        "LOGIN",
                                        style: AppTheme.getTextStyle(themeData.textTheme.headline6, fontWeight: 600),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: MySize.size16, right: MySize.size16),
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                letterSpacing: 0.1, color: themeData.colorScheme.onBackground, fontWeight: 500),
                                            controller: model.emailTextController,
                                            decoration: InputDecoration(
                                              hintText: "Email",
                                              hintStyle: AppTheme.getTextStyle(themeData.textTheme.subtitle2,
                                                  letterSpacing: 0.1, color: themeData.colorScheme.onBackground, fontWeight: 500),
                                              prefixIcon: Icon(MdiIcons.emailOutline),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: MySize.size16),
                                            child: TextFormField(
                                              style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                  letterSpacing: 0.1, color: themeData.colorScheme.onBackground, fontWeight: 500),
                                              controller: model.passwordTextController,
                                              decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: AppTheme.getTextStyle(themeData.textTheme.subtitle2,
                                                    letterSpacing: 0.1, color: themeData.colorScheme.onBackground, fontWeight: 500),
                                                prefixIcon: Icon(MdiIcons.lockOutline),
                                                suffixIcon: IconButton(
                                                  icon: Icon(model.passwordVisible ? MdiIcons.eyeOutline : MdiIcons.eyeOffOutline),
                                                  onPressed: () {
                                                    model.setPasswordVisible();
                                                  },
                                                ),
                                              ),
                                              obscureText: model.passwordVisible,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: MySize.size16),
                                            alignment: Alignment.centerRight,
                                            child: Text("Forgot Password?", style: AppTheme.getTextStyle(themeData.textTheme.bodyText2, fontWeight: 500)),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: <Widget>[
                                                Checkbox(
                                                  activeColor: themeData.colorScheme.primary,
                                                  onChanged: (bool value) {
                                                    model.setCheckedBoxValue(value);
                                                  },
                                                  value: model.isRememberCheck,
                                                  visualDensity: VisualDensity.compact,
                                                ),
                                                Text(
                                                  "Remember me",
                                                  style: themeData.textTheme.bodyText2.merge(TextStyle(color: themeData.colorScheme.onBackground)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: MySize.size16),
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(MySize.size24)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: themeData.colorScheme.primary.withAlpha(18),
                                                  blurRadius: 3,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: FlatButton(
                                                padding: EdgeInsets.only(top: MySize.size10, bottom: MySize.size10),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                                color: themeData.colorScheme.primary,
                                                splashColor: Colors.white,
                                                onPressed: () {
                                                  if (model.isValidSignIn(email: model.emailTextController.text, password: model.passwordTextController.text)) {
                                                    showIosProgressDialog(context);

                                                    model.firebaseApi
                                                        .signInWithEmailAndPassword(
                                                            email: model.emailTextController.text.trim(),
                                                            password: model.passwordTextController.text.trim(),
                                                            isRemember: model.isRememberCheck)
                                                        .then((value) {
                                                      Navigator.pop(context);

                                                      if (model.firebaseApi.signErrorMessage.trim().isNotEmpty) {
                                                        _scaffoldKey.currentState.showSnackBar(customSnackBar(model.firebaseApi.signErrorMessage, themeData));
                                                      } else {
                                                        AppRoutes.navigateUntil(AppRoutes.chatHomeScreen, context);
                                                      }
                                                    });
                                                  } else {
                                                    _scaffoldKey.currentState.showSnackBar(customSnackBar(model.signInErrorMessage, themeData));
                                                  }
                                                },
                                                child: Text("LOGIN",
                                                    style: AppTheme.getTextStyle(themeData.textTheme.button,
                                                        fontWeight: 600, color: themeData.colorScheme.onPrimary, letterSpacing: 0.5))),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: MySize.size16),
                                            child: Center(
                                              child: Text(
                                                "OR",
                                                style: AppTheme.getTextStyle(themeData.textTheme.bodyText2, fontWeight: 500),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(MySize.size24)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: themeData.colorScheme.primary.withAlpha(18),
                                                  blurRadius: 3,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: FlatButton(
                                                padding: EdgeInsets.only(top: MySize.size10, bottom: MySize.size10),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MySize.size20)),
                                                color: themeData.colorScheme.primary,
                                                splashColor: Colors.white,
                                                onPressed: () {
                                                  model.firebaseApi
                                                      .signWithGoogle(function: showIosProgressDialog(context), isRemember: model.isRememberCheck)
                                                      .then((value) {
                                                    if (model.firebaseApi.signErrorMessage.trim().isNotEmpty) {
                                                      _scaffoldKey.currentState.showSnackBar(customSnackBar(model.firebaseApi.signErrorMessage, themeData));
                                                    } else {
                                                      AppRoutes.navigateUntil(AppRoutes.chatHomeScreen, context);
                                                    }
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      "Login with Google",
                                                      style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                                                          fontWeight: 600, color: themeData.colorScheme.onPrimary, letterSpacing: 0.3),
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
                                AppRoutes.navigate(AppRoutes.registerScreen, context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: MySize.size16),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(text: "Don't have an Account? ", style: AppTheme.getTextStyle(themeData.textTheme.bodyText2, fontWeight: 500)),
                                      TextSpan(
                                          text: " Register",
                                          style: AppTheme.getTextStyle(themeData.textTheme.bodyText2, fontWeight: 600, color: themeData.colorScheme.primary)),
                                    ]),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )));
      },
    );
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
