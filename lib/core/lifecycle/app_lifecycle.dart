import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

mixin class AppLifecycleMixin {
  AppLifecycleState _lifecycleState = AppLifecycleState.resumed;

  AppLifecycleState get currentLifecycleState => _lifecycleState;

  void _handleLifecycleChange(AppLifecycleState state) {
    _lifecycleState = state;
    // Add your logic based on the app lifecycle state change
    if (kDebugMode) {
      print('AppLifecycleState: $state');
    }
  }
}

class CustomWidgetsBindingObserver extends WidgetsBindingObserver with AppLifecycleMixin {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _handleLifecycleChange(state);
  }
}

class AppLifecycleListener {
  static final AppLifecycleListener _instance = AppLifecycleListener._internal();
  final CustomWidgetsBindingObserver _observer = CustomWidgetsBindingObserver();

  factory AppLifecycleListener() {
    return _instance;
  }

  AppLifecycleListener._internal() {
    // Register observer in the constructor
    WidgetsBinding.instance.addObserver(_observer);
  }

  // Dispose method to remove the observer when it's no longer needed
  void dispose() {
    WidgetsBinding.instance.removeObserver(_observer);
  }
}
