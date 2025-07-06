import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    String? age,
    String? sex,
    String? trainingEnvironment,
    String? intensity,
    String? objection,
    String? often,
    String? height,
    String? weight,
  }) = _UserSettings;
}

extension UserSettingsExt on UserSettings {
  Map<String, String> toMap() {
    return {
      'age': age ?? '',
      'sex': sex ?? '',
      'trainingEnvironment': trainingEnvironment ?? '',
      'intensity': intensity ?? '',
      'objection': objection ?? '',
      'often': often ?? '',
      'height': height ?? '',
      'weight': weight ?? '',
    };
  }
}
