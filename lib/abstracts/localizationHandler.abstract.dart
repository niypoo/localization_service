import 'package:localization_service/models/language.model.dart';

abstract class LocalizationHandler{

  Future<void> init(Language language);
  Future<void> update(Language language);

}