import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:train_menu_creator/create/application/business_logics/edit_training_settinngs_usecase.dart';

part 'create_setting_screen_view_model.freezed.dart';

final settingScreenProvider =
    StateNotifierProvider<SettingScreenViewModel, SettingScreenState>((ref) {
      final settingUseCase = ref.watch(settingsUseCaseProvider);
      return SettingScreenViewModel(settingsUseCase: settingUseCase);
    });

@freezed
class SettingScreenState with _$SettingScreenState {
  /// there is no need to declare state
  /// but for the future extension
  const factory SettingScreenState() = _SettingScreenState;
}

class SettingScreenViewModel extends StateNotifier<SettingScreenState> {
  SettingScreenViewModel({required EditTrainingSettingsUseCase settingsUseCase})
    : _settingsUseCase = settingsUseCase,
      super(const SettingScreenState());

  final EditTrainingSettingsUseCase _settingsUseCase;

  void saveSetting({
    String? objection,
    String? often,
    String? intensity,
    String? environment,
    String? weight,
    String? height,
    String? gender,
    String? age,
  }) {
    _settingsUseCase.setSettings(
      objection: objection,
      often: often,
      intensity: intensity,
      environment: environment,
      weight: weight,
      height: height,
      gender: gender,
      age: age,
    );
  }
}
