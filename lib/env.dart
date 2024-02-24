// env.dart

const String flavor = String.fromEnvironment('FLAVOR', defaultValue: 'local');
const bool isDebug = bool.fromEnvironment('DEBUG', defaultValue: true);
