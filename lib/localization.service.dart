import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_storage_service/localStorage.service.dart';
import 'package:localization_service/models/language.model.dart';

class LocalizationService extends GetxService {
  //define a controller in to
  static LocalizationService get to => Get.find();

  //app support Languages
  final List<Language> supportedLanguages;

  // default language
  final Language defaultLanguage;

  // current language
  final Rx<Language?> selectedLanguage = Rx(null);

  // constructors
  LocalizationService({
    required this.supportedLanguages,
    required this.defaultLanguage,
  });

  // initialization
  Future<LocalizationService> init() async {
    _setDefaultLAnguage();
    return this;
  }

  // get current language
  Language get language => selectedLanguage.value ?? defaultLanguage;

  // return stored locale or device locale
  _setDefaultLAnguage() {
    // read stored language if exist before
    final String selectedLocale =
        LocaleStorageService.to.instance.read('selectedLocale') ??
            Get.deviceLocale!.languageCode;

    // if not stored before used locale of device
    selectedLanguage.value = getLanguageByLanguageCode(selectedLocale);
  }

  Language getLanguageByLanguageCode(String code) {
    return supportedLanguages
            .firstWhereOrNull((language) => language.code == code) ??
        defaultLanguage;
  }

  bool get isRTL {
    return (language.dir == 'rtl');
  }

  List<Locale> get supportedLocales =>
      supportedLanguages.map((language) => Locale(language.code)).toList();

  Future<void> appChangeLocale(String languageKey) async {
    // store new language
    LocaleStorageService.to.instance.write('selectedLocale', languageKey);

    // if not stored before used locale of device
    selectedLanguage.value = getLanguageByLanguageCode(languageKey);

    // update locale of app
    Get.updateLocale(Locale(languageKey));

    // this delay fix card and some element have not localization changes
    await Future.delayed(const Duration(milliseconds: 300));

    // force app update
    Get.forceAppUpdate();
  }
}


 
  // List<String> supportedStringLocales() {
  //   return supportedLanguages.map((language) => language.code).toList();
  // }

  // Language get getCurrentLanguage {
  //   return supportedLanguages!.firstWhere(
  //       (language) => language.code == getCurrentLocale!.languageCode);
  // }
