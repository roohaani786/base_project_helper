import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import '../../domain/config/logger_config.dart';

class NetworkManager {
  final StreamController<bool> _connectionStatusController =
  StreamController<bool>.broadcast();
  double _currentInternetSpeed = 0.0;
  bool internetSpeedTested = false;

  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  Future<void> checkInternetConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    bool isConnected = result != ConnectivityResult.none;
    _connectionStatusController.add(isConnected);

    if (isConnected && !internetSpeedTested) {
      // Perform the speed test only if not tested before
      await _checkInternetSpeed();
    }
  }

  Future<void> _checkInternetSpeed() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.apple.com'),
        headers: {'Cache-Control': 'no-cache', 'Pragma': 'no-cache'},
      );

      final downloadTimeString = response.headers['date'];
      if (downloadTimeString != null) {
        try {
          final downloadTime = HttpDate.parse(downloadTimeString);

          // ignore: unnecessary_null_comparison
          if (downloadTime != null) {
            final duration =
                DateTime.now().difference(downloadTime).inMilliseconds;

            final speedInBytesPerSecond =
                (response.bodyBytes.length / duration) * 1000;
            final speedInMegabytesPerSecond =
                speedInBytesPerSecond / (1024 * 1024);

            _currentInternetSpeed = speedInMegabytesPerSecond;

            logger.i('Internet speed: $_currentInternetSpeed MB/s');

            if (isInternetSlow(_currentInternetSpeed) && _currentInternetSpeed != 0.0) {
              logger.i('Your Internet looks Slow');
              // You can show a snackbar here if needed
            }
            else if (_currentInternetSpeed == 0.0){
              logger.i('No Internet');
            }
          } else {
            logger.e('Error parsing download time: Invalid date format');
          }
        } catch (e) {
          logger.e('Error parsing download time: $e');
        }
      } else {
        logger.e('Download time not available in response headers');
      }

      // Mark speed test as completed
      internetSpeedTested = true;
    } catch (e) {
      logger.e('Error checking internet speed: $e');
    }
  }

  bool isInternetSlow(double thresholdSpeedInMegabytesPerSecond) {
    print(getCurrentInternetSpeed());
    print(thresholdSpeedInMegabytesPerSecond);
    return getCurrentInternetSpeed() < thresholdSpeedInMegabytesPerSecond;
  }

  double getCurrentInternetSpeed() {
    return _currentInternetSpeed;
  }

  void startMonitoring() {
    Connectivity().onConnectivityChanged.listen((result) {
      bool isConnected = result != ConnectivityResult.none;
      _connectionStatusController.add(isConnected);
      if (isConnected && !internetSpeedTested) {
        // Perform the speed test only if not tested before
        _checkInternetSpeed();
      }
    });
  }

  void dispose() {
    _connectionStatusController.close();
  }
}

final NetworkManager networkManager = NetworkManager();
