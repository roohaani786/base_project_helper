import 'dart:convert';
import 'package:dubai_ble/domain/config/logger_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    logger.i("Language code : ${locale.languageCode}");
    try {
      // Load the JSON file with translations
      String jsonString =
      await rootBundle.loadString('l10n_assets/intl_${locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Convert JSON format to Map<String, String>
      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });

      return true;
    } catch (e) {
      print('Error loading translation file: $e');
      return false;
    }
  }



  // Helper method to get the translated string
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // Define a static method to load the AppLocalizations class
  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all supported locales here
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}


class CustomAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>?> load(String localePath, Locale locale) async {
    print('Loading asset: $localePath');
    String jsonString = await rootBundle.loadString(localePath);
    Map<String, dynamic> arbMap = json.decode(jsonString);
    return arbMap.cast<String, dynamic>();
  }

}


