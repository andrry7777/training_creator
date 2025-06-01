import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:train_menu_creator/create/domain/entity/user_settings.dart';
import 'package:train_menu_creator/create/domain/repositoryies/interface_create_menu_settings.dart';
import 'package:train_menu_creator/create/infrastructure/repository/user_setting_repository_impl.dart';

final settingsUseCaseProvider = Provider<EditTrainingSettingsUseCase>((ref) {
  final repository = ref.read(settingRepositoryProvider);
  return EditTrainingSettingsUseCase(repository: repository);
});

class EditTrainingSettingsUseCase {
  const EditTrainingSettingsUseCase({required this.repository});

  final SettingsOfCreateMenuRepository repository;

  void setSettings({
    String? objection,
    String? often,
    String? intensity,
    String? environment,
    String? weight,
    String? height,
    String? gender,
    String? age,
  }) async {
    final settings = UserSettings(
      age: age,
      sex: gender,
      height: height,
      weight: weight,
      trainingEnvironment: environment,
      intensity: intensity,
      often: often,
      objection: objection,
    );

    /// null members are not saved
    /// so there is no need to check them to avoid override
    await repository.saveUserSettings(setting: settings);
  }

  Future<UserSettings> getSettings() async {
    return await repository.fetchUserSettings();
  }
}
