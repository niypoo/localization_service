import 'package:bottom_sheet_helper/models/actionSheetOption.model.dart';
import 'package:bottom_sheet_helper/services/actionSheet.helper.dart';
import 'package:fly_ui/views/widgets/images/imageSVG.widget.dart';
import 'package:get/get.dart';
import 'package:localization_service/localization.service.dart';

class LocalizationPickerService {
  static Future<String?> show() async => await ActionSheetHelper.show(
        title: 'LOCALIZATION.Languages'.tr,
        subTitle: 'LOCALIZATION.Change the locale of app to fit your knowledge.'.tr,
        currentValue: LocalizationService.to.language.code,
        options: LocalizationService.to.supportedLanguages
            .map(
              (language) => ActionSheetOption(
                title: language.name,
                value: language.code,
                leading: FlyImageSVG(
                  path: 'assets/flags/${language.code}.svg',
                ),
              ),
            )
            .toList(),
      ) as String?;
}
