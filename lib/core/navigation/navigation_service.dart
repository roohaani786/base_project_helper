// core/navigation/navigation_service.dart
import 'package:flutter/material.dart';

class NavigationService {
  // Singleton instance
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();

  // Navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Sample navigation methods
  void navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void navigateToDetail(BuildContext context) {
    Navigator.pushNamed(context, '/detail');
  }

  // Additional navigation methods
  void navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  void navigateToSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings');
  }

  void navigateToNotifications(BuildContext context) {
    Navigator.pushNamed(context, '/notifications');
  }

  // Additional navigation methods
  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  void pushReplacement(BuildContext context, Widget newWidget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => newWidget),
    );
  }

  void pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  void pushNamedAndRemoveUntil(BuildContext context, String newRouteName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      newRouteName,
          (Route<dynamic> route) => false,
    );
  }

// Add more navigation methods as needed
}
