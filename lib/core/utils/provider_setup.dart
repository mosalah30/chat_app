// provider_setup.dart
import 'package:chat_app/core/services/api/api.dart';
import 'package:chat_app/core/services/api/fake_api.dart';
import 'package:chat_app/core/services/api/http_api.dart';
import 'package:chat_app/core/services/auth/authentication_service.dart';
import 'package:chat_app/core/services/database/database.dart';
import 'package:chat_app/core/services/localization/localization.dart';
import 'package:chat_app/core/services/theme/theme_provider.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../services/connectivity/connectivity_service.dart';
import '../services/notification/notification_service.dart';

const bool USE_FAKE_IMPLEMENTATION = true;

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  Provider(create: (_) => () => DB()),
  Provider<Api>(create: (_) => USE_FAKE_IMPLEMENTATION ? FakeApi() : HttpApi()),
  ChangeNotifierProvider<ConnectivityService>(create: (context) => ConnectivityService()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(update: (context, api, authenticationService) => AuthenticationService(api: api)),
   ProxyProvider<AuthenticationService, NotificationService>(update: (context, auth, ns) => NotificationService(auth: auth)),
];

List<SingleChildWidget> uiConsumableProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ChangeNotifierProvider<AppLanguageModel>(create: (_) => AppLanguageModel()),
];
