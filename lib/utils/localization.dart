// Localization support for multilingual features
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate = 
    _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Supported languages
  static const List<String> supportedLanguages = ['en', 'lg', 'sw']; // English, Luganda, Swahili

  late Map<String, String> _localizedStrings;

  Future<bool> load(Locale locale) async {
    // Load the language JSON file from the assets/languages folder
    String jsonString = await rootBundle.loadString('assets/languages/${locale.languageCode}.json');
    
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // Common translations
  String get welcome => translate('welcome');
  String get selectRole => translate('select_role');
  String get farmer => translate('farmer');
  String get group => translate('group');
  String get agronomist => translate('agronomist');
  String get continueBtn => translate('continue');
  String get guestMode => translate('guest_mode');
  String get home => translate('home');
  String get services => translate('services');
  String get markets => translate('markets');
  String get profile => translate('profile');
  String get weather => translate('weather');
  String get alerts => translate('alerts');
  String get aiAdvisory => translate('ai_advisory');
  String get creditScore => translate('credit_score');
  String get myFarm => translate('my_farm');
  String get marketPrices => translate('market_prices');
  String get yieldPrediction => translate('yield_prediction');
  String get buyInputs => translate('buy_inputs');
  String get getServices => translate('get_services');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations();
    await localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}