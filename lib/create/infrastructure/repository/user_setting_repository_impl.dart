import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_menu_creator/create/domain/entity/user_settings.dart';
import 'package:train_menu_creator/create/domain/repositoryies/interface_create_menu_settings.dart';

final settingRepositoryProvider = Provider(
  (ref) => SettingsOfCreateMenuRepositoryImpl(),
);

class SettingsOfCreateMenuRepositoryImpl
    implements SettingsOfCreateMenuRepository {
  @override
  Future<void> saveUserSettings({required UserSettings setting}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final settingsMap = setting.toMap();
    settingsMap.forEach((key, value) {
      if (value.isEmpty) return;
      sharedPreferences.setString(key, value);
    });
  }

  @override
  Future<UserSettings> fetchUserSettings() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final age = sharedPreferences.getString('age') ?? '20';
    final height = sharedPreferences.getString('height') ?? '170';
    final weight = sharedPreferences.getString('weight') ?? '60';
    final gender = sharedPreferences.getString('gender') ?? 'male';
    final intensity = sharedPreferences.getString('intensity') ?? '中級者';
    final trainingEnvironment =
        sharedPreferences.getString('trainingEnvironment') ?? 'ジム';
    final objection = sharedPreferences.getString('objection') ?? '筋力増強';
    final often = sharedPreferences.getString('often') ?? '毎日';

    return UserSettings(
      age: age,
      height: height,
      weight: weight,
      sex: gender,
      intensity: intensity,
      trainingEnvironment: trainingEnvironment,
      objection: objection,
      often: often,
    );
  }
}
