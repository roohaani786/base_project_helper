// domain/config/logger_config.dart

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';

void _initLogFile() async {
  try {
    final appDocDir = await getApplicationDocumentsDirectory();
    final logFile = File('${appDocDir.path}/exception_log.txt');

    if (!logFile.existsSync()) {
      logFile.createSync();
    }
  } catch (e) {
    // Handle or log the exception that occurred during file initialization
    logger.e('Exception during file initialization: $e');
  }
}

void logExceptionToFile(String exception) async {
  try {
    final appDocDir = await getApplicationDocumentsDirectory();
    final logFile = File('${appDocDir.path}/exception_log.txt');

    logFile.writeAsStringSync('$exception\n', mode: FileMode.append);
  } catch (e) {
    // Handle or log the exception that occurred during writing to the file
    logger.e('Exception during writing to file: $e');
  }
}

void initializeLoggerConfig() {
  // Call the file initialization method
  _initLogFile();
}

final Logger logger = Logger(
  printer: PrettyPrinter(),
);
