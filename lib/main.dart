import 'package:chat_app/AppTheme.dart';
import 'package:chat_app/AppThemeNotifier.dart';
import 'package:chat_app/pages/Login2Screen.dart';
import 'package:chat_app/pages/chat_home_Page/ChatHomeScreen.dart';
import 'package:chat_app/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/services/preference/preference.dart';
import 'pages/ChatScreen.dart';
void main() {

  //You will need to initialize AppThemeNotifier class for theme changes.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ChangeNotifierProvider<AppThemeNotifier>(
      create: (context) => AppThemeNotifier(),
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (c, v, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(v.themeMode()),
          home: Login2Screen(),
        );
      },
    );
  }
}
