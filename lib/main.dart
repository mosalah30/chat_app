import 'package:chat_app/AppTheme.dart';
import 'package:chat_app/core/services/localization/localization.dart';
import 'package:chat_app/pages/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/services/preference/preference.dart';
import 'core/services/theme/theme_provider.dart';
import 'core/utils/provider_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Preference.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: providers,
      child: Consumer2<AppLanguageModel, ThemeProvider>(
        builder: (c, v,l, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getThemeFromThemeMode(0),
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
