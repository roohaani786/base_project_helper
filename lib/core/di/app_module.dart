// core/di/app_module.dart

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../domain/config/logger_config.dart';
import '../navigation/navigation_service.dart';

final getIt = GetIt.instance;

final NavigationService navigationService = NavigationService();

void setupDependencies() {
  // Register your dependencies here (use cases, repositories, services, etc.)
     getIt.registerSingleton<Logger>(logger);
  // Register the service in the dependency injection container
     getIt.registerSingleton<NavigationService>(navigationService);
  // getIt.registerSingleton<YourRepository>(() => YourRepositoryImpl());
  // getIt.registerSingleton<YourUseCase>(() => YourUseCaseImpl());
  // Add other registrations as needed
}

