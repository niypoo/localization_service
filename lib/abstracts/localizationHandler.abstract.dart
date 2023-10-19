import 'package:localization_service/models/language.model.dart';

abstract class LocalizationServiceHandler{

  Future<void> init(Language language);
  Future<void> update(Language language);

}