import 'package:flutter/widgets.dart';
import 'package:fly_ui/views/cards/setting.widget.dart';
import 'package:get/get.dart';
import 'package:localization_service/localization.service.dart';
import 'package:localization_service/localizationPicker.dart';

class LocalizationSettingCard extends StatefulWidget {
  const LocalizationSettingCard({Key? key}) : super(key: key);

  @override
  State<LocalizationSettingCard> createState() =>
      _LocalizationSettingCardState();
}

class _LocalizationSettingCardState extends State<LocalizationSettingCard> {
  @override
  Widget build(BuildContext context) {
    return // Language
        FlySettingCard(
      title: 'LOCALIZATION.Language'.tr,
      onTap: () async {
        // show picker
        final String? language = await LocalizationPickerService.show();

        // skip
        if (language == null) return;

        // change  app localization
        await LocalizationService.to.appChangeLocale(language);

        setState(() {});
      },
      trailing: Text(
        LocalizationService.to.language.name,
        style: Get.textTheme.bodySmall,
      ),
    );
  }
}
