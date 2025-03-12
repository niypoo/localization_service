import 'package:flutter/widgets.dart';
import 'package:fly_ui/views/drawer/widgets/drawerButton.widget.dart';
import 'package:get/get.dart';
import 'package:localization_service/localization.service.dart';
import 'package:localization_service/localizationPicker.dart';
import 'package:unicons/unicons.dart';

class LocalizationDrawerSettingCard extends StatefulWidget {
  const LocalizationDrawerSettingCard({Key? key}) : super(key: key);

  @override
  State<LocalizationDrawerSettingCard> createState() =>
      _LocalizationDrawerSettingCardState();
}

class _LocalizationDrawerSettingCardState
    extends State<LocalizationDrawerSettingCard> {
  @override
  Widget build(BuildContext context) {
    return // Language
        FlyDrawerButton(
      title: 'LOCALIZATION.Language'.tr,
      icon: UniconsLine.language,
      value: LocalizationService.to.language.name,
      onTap: () async {
        // show picker
        final String? language = await LocalizationPickerService.show();

        // skip
        if (language == null) return;

        // change  app localization
        await LocalizationService.to.appChangeLocale(language);

        setState(() {});
      },
    );
  }
}
