import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:uuid/uuid.dart';

part 'training_menus.freezed.dart';

@freezed
class TrainingMenu with _$TrainingMenu {
  factory TrainingMenu({
    required TrainPart trainPart,
    required String menu,
    required int rest,
    required int weight,
    required int reps,
    @Default('') String id,
    @Default('') String advice,
  }) = _TrainingMenu;
}

/// Geminiから来た値をentityに変換するヘルパー
List<TrainingMenu> convertGeminiResponseToTrainingMenu(String geminiResponse) {
  // レスポンスから不要な文字列を削除
  final cleaned = geminiResponse
      .replaceAll('\n', '')
      .replaceAll(RegExp(r'\\?\"'), '"')
      .replaceAll("'", '"');

  final jsonList = jsonDecode(cleaned);
  final uuid = Uuid();
  return jsonList.map<TrainingMenu>((item) {
    final menu = item['menu'] as String?;
    final rest = item['rest'] as int?;
    final weight = item['weight'] as int?;
    final reps = item['reps'] as int?;
    final advice = item['advice'] as String?;
    final trainPartString =
        item['part'] as String? ?? TrainPart.other.getStringName;
    final trainPart = TrainPart.values.firstWhere(
      (e) => e.getStringName == trainPartString,
    );
    return TrainingMenu(
      trainPart: trainPart,
      menu: menu ?? '',
      rest: rest ?? 60,
      weight: weight ?? 100,
      reps: reps ?? 10,
      advice: advice ?? '',
      id: uuid.v4(),
    );
  }).toList();
}
