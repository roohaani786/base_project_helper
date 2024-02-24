import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../core/di/app_module.dart';
import '../../core/network/network_status_wrapper.dart';
import '../../l10n/app_localizations.dart';

// Use a single GlobalKey for ScaffoldMessenger
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: const NetworkStatusWrapper(
        child: MyHomePage(),
      ),
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: navigatorKey,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logger = getIt<Logger>();

    logger.d('${runtimeType.toString()} - loaded');

    return Scaffold(
      appBar: AppBar(
        title: Text('hello'.tr()),
        actions: [
          _buildLanguageButton(context, 'en', 'US'),
          _buildLanguageButton(context, 'ar', 'AR'),
        ],
      ),
      body: Center(
        child: Text('hello'.tr()),
      ),
    );
  }

  Widget _buildLanguageButton(
      BuildContext context, String languageCode, String countryCode) {
    return TextButton(
      onPressed: () {
        _changeLanguage(context, languageCode, countryCode);
      },
      child: Text(languageCode.toUpperCase(),
          style: const TextStyle(color: Colors.black)),
    );
  }

  void _changeLanguage(
      BuildContext context, String languageCode, String countryCode) {
    context.setLocale(Locale(languageCode, countryCode));
  }
}