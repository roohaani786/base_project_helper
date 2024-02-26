import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'core/network/network_manager.dart';
import 'presentation/ui/home_page.dart';

//
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final getIt = GetIt.instance;

void setupDependencies() {
  // Logger
  getIt.registerLazySingleton<Logger>(() => Logger());

  // Network Manager
  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  final networkManager = getIt<NetworkManager>();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
      path: 'l10n_assets',
      fallbackLocale: const Locale('en', 'US'),
      useFallbackTranslations: true,
      startLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );


  networkManager.startMonitoring();
  networkManager.checkInternetConnectivity();
}
