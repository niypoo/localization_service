import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_storage_service/localStorage.service.dart';
import 'package:localization_service/models/language.model.dart';

class LocalizationService extends GetxService {
  //define a controller in to
  static LocalizationService get to => Get.find();

  // Languages
  final List<Language>? languages;

  final RxBool changes = RxBool(false);

  // constructors
  LocalizationService({this.languages});

  // initialization
  Future<LocalizationService> init() async {
    return this;
  }

  // return stored locale or device locale
  static Locale? get getCurrentLocale {
    // read stored language if exist before
    final String? selectedLocale =
        LocaleStorageService.to.instance.read('selectedLocale');

    // if not stored before used locale of device
    return selectedLocale == null ? Get.deviceLocale : Locale(selectedLocale);
  }

  List<Locale> get supportedLocales =>
      languages!.map((language) => Locale(language.code)).toList();

  List<String> supportedStringLocales() {
    return languages!.map((language) => language.code).toList();
  }

  Language get getCurrentLanguage {
    return languages!.firstWhere(
        (language) => language.code == getCurrentLocale!.languageCode);
  }

  Language getLanguageByCode(String languageCode) {
    return languages!.firstWhere((language) => language.code == languageCode);
  }

  bool get isRTL {
    Language currentLang = getLanguageByCode(getCurrentLocale!.languageCode);
    return currentLang.dir == 'rtl';
  }

  Future<void> appChangeLocale(String languageKey) async {
    // store new language
    LocaleStorageService.to.instance.write('selectedLocale', languageKey);

    // update locale of app
    Get.updateLocale(Locale(languageKey));

    // this delay fix card and some element have not localization changes
    await Future.delayed(const Duration(milliseconds: 300));

    // listener
    changes.value = !changes.value;

    // force app update
    Get.forceAppUpdate();
  }
}
