import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dubai_ble/presentation/bloc/todo/todo_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/src/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'core/di/app_module.dart';
import 'core/enums.dart';
import 'core/logging/easy_logger.dart';
import 'core/network/network_manager.dart';
import 'data/api/api_manager.dart';
import 'presentation/ui/home_page.dart';

//
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final getIt = GetIt.instance;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  final networkManager = getIt<NetworkManager>();


  EasyLocalization.logger.defaultLevel = LevelMessages.debug;
  EasyLocalization.logger.enableLevels = [LevelMessages.info];

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
      path: 'l10n_assets',
      fallbackLocale: const Locale('en', 'US'),
      useFallbackTranslations: true,
      startLocale: const Locale('en', 'US'),
      child: BlocProvider(
          create: (context) => TodoBloc(),  // Initialize your BLoC here
          child: const MyApp()
      ),

    ),
  );


  networkManager.startMonitoring();
  networkManager.checkInternetConnectivity();
}
