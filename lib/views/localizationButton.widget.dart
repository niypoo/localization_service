import 'package:flutter/material.dart';
import 'package:fly_ui/views/widgets/containers/container.widget.dart';
import 'package:fly_ui/views/widgets/inkWell.widget.dart';
import 'package:get/get.dart';
import 'package:localization_service/localization.service.dart';
import 'package:localization_service/localizationPicker.dart';

class ChangeLocalizationButton extends StatefulWidget {
  const ChangeLocalizationButton({Key? key}) : super(key: key);

  @override
  State<ChangeLocalizationButton> createState() =>
      _ChangeLocalizationButtonState();
}

class _ChangeLocalizationButtonState extends State<ChangeLocalizationButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlyInkWell(
          onTap: () async {
            // show picker
            final String? language = await LocalizationPickerService.show();

            // skip
            if (language == null) return;

            // change  app localization
            await LocalizationService.to.appChangeLocale(language);

            setState(() {});
          },
          child: FlyContainer(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_drop_down_rounded),
                Text(
                  LocalizationService.to.getCurrentLanguage.name,
                  style: Get.textTheme.titleSmall,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
