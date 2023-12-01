/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';

class AppLocalizations {
  final Locale? locale;
  static AppLocalizations? instance;

  AppLocalizations(this.locale);

  AppLocalizations._init(this.locale) {
    instance = this;
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _ApplicationLocalizationDelegate();

  Map<String, String>? localizedStrings;

  Future<bool> load(Locale locale) async {
    print("TEST_LOG ==locale==> ${locale}");
    String jsonString = await rootBundle
        .loadString('assets/languages/${locale?.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    return localizedStrings?[key] ?? key;
  }
}

class _ApplicationLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _ApplicationLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppConstant.supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations._init(locale);
    try {
      await localizations.load(
          Locale.fromSubtags(languageCode: appStoragePref.getStoreCode()));
    } catch (e) {
      await localizations.load(
          const Locale.fromSubtags(languageCode: AppConstant.defaultStoreCode));
    }
    return localizations;
  }

  @override
  bool shouldReload(_ApplicationLocalizationDelegate old) => false;
}

extension StringExtension on String {
  String localized() {
    return AppLocalizations.instance?.translate(this) ?? this;
  }
}
