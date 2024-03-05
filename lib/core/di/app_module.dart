// core/di/app_module.dart

import 'package:dio/dio.dart';
import 'package:dubai_ble/core/network/network_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../data/api/api_manager.dart';
import '../../domain/config/logger_config.dart';
import '../navigation/navigation_service.dart';

final getIt = GetIt.instance;

final NavigationService navigationService = NavigationService();

void setupDependencies() {
  // Register your dependencies here (use cases, repositories, services, etc.)
     getIt.registerSingleton<Logger>(logger);

     getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());
  // Register the service in the dependency injection container
     getIt.registerSingleton<NavigationService>(navigationService);

     final dio = Dio(); // Create your Dio instance with desired configurations
  getIt.registerSingleton<Dio>(dio);
//
//
  getIt.registerSingleton<ApiManager>(ApiManager(getIt<Dio>()));
  // getIt.registerSingleton<YourRepository>(() => YourRepositoryImpl());
  // getIt.registerSingleton<YourUseCase>(() => YourUseCaseImpl());
  // Add other registrations as needed
}

