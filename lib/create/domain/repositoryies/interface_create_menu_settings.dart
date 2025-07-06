import 'package:train_menu_creator/create/domain/entity/user_settings.dart';

abstract class SettingsOfCreateMenuRepository {
  Future<void> saveUserSettings({required UserSettings setting});

  Future<UserSettings> fetchUserSettings();
}
