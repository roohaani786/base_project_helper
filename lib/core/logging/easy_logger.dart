// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import '../enums.dart';
//
// class EasyLogger {
//   EasyLogger({
//     this.name = '',
//     this.enableBuildModes = const <BuildMode>[
//       BuildMode.profile,
//       BuildMode.debug,
//     ],
//     this.enableLevels = const <LevelMessages>[
//       LevelMessages.debug,
//       LevelMessages.info,
//       LevelMessages.error,
//       LevelMessages.warning,
//     ],
//     EasyLogPrinter? printer,
//     this.defaultLevel = LevelMessages.info,
//   }) {
//     _printer = printer ?? _defaultPrinter;
//     _currentBuildMode = _getCurrentBuildMode();
//   }
//
//   BuildMode? _currentBuildMode;
//
//   String name;
//   List<BuildMode> enableBuildModes;
//   List<LevelMessages> enableLevels;
//   LevelMessages defaultLevel;
//
//   EasyLogPrinter? _printer;
//
//   EasyLogPrinter? get printer => _printer;
//
//   set printer(EasyLogPrinter? newPrinter) => _printer = newPrinter;
//
//   BuildMode _getCurrentBuildMode() {
//     if (kReleaseMode) {
//       return BuildMode.release;
//     } else if (kProfileMode) {
//       return BuildMode.profile;
//     }
//     return BuildMode.debug;
//   }
//
//   bool isEnabled(LevelMessages level) {
//     if (!enableBuildModes.contains(_currentBuildMode)) {
//       return false;
//     }
//     if (!enableLevels.contains(level)) {
//       return false;
//     }
//     return true;
//   }
//
//   void call(Object object, {StackTrace? stackTrace, LevelMessages? level}) {
//     level ??= defaultLevel;
//     if (isEnabled(level)) {
//       _printer!(object, stackTrace: stackTrace, level: level, name: name);
//     }
//   }
//
//   void debug(Object object, {StackTrace? stackTrace}) =>
//       call(object, stackTrace: stackTrace, level: LevelMessages.debug);
//
//   void info(Object object, {StackTrace? stackTrace}) =>
//       call(object, stackTrace: stackTrace, level: LevelMessages.info);
//
//   void warning(Object object, {StackTrace? stackTrace}) =>
//       call(object, stackTrace: stackTrace, level: LevelMessages.warning);
//
//   void error(Object object, {StackTrace? stackTrace}) =>
//       call(object, stackTrace: stackTrace, level: LevelMessages.error);
//
//   void _defaultPrinter(Object object,
//       {StackTrace? stackTrace, LevelMessages? level, String? name}) {
//     final emoji = _getEmojiForLevel(level);
//     final color = _getColorForLevel(level);
//     final time = DateTime.now().toLocal().toString().split(' ')[1];
//
//     print(
//         '$emoji $time [$name] ${level?.toString().split('.').last}: $object');
//
//     if (stackTrace != null) {
//       print(stackTrace);
//     }
//   }
//
//   String _getEmojiForLevel(LevelMessages? level) {
//     switch (level) {
//       case LevelMessages.debug:
//         return '🐞';
//       case LevelMessages.info:
//         return 'ℹ️';
//       case LevelMessages.warning:
//         return '⚠️';
//       case LevelMessages.error:
//         return '❌';
//       default:
//         return '';
//     }
//   }
//
//   Color _getColorForLevel(LevelMessages? level) {
//     switch (level) {
//       case LevelMessages.debug:
//         return Colors.blue;
//       case LevelMessages.info:
//         return Colors.green;
//       case LevelMessages.warning:
//         return Colors.orange;
//       case LevelMessages.error:
//         return Colors.red;
//       default:
//         return Colors.black;
//     }
//   }
// }
//
//
// /// Type for function printing/logging in [EasyLogger].
// typedef EasyLogPrinter = Function(Object object,
//     {String? name, LevelMessages? level, StackTrace? stackTrace});
