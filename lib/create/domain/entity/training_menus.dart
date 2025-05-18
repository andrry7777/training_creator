import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';

part 'training_menus.freezed.dart';

@freezed
class TrainingMenu with _$TrainingMenu {
  const factory TrainingMenu({
    required TrainPart trainPart,
    required String menu,
    required int rest,
    required int weight,
    required int reps,
  }) = _TrainingMenu;
}

/// Geminiから来た値をentityに変換するヘルパー
List<TrainingMenu> convertGeminiResponseToTrainingMenu(
  String geminiResponse,
  TrainPart trainPart,
) {
  final regex = RegExp(r'\[([^\]]+)\]');
  final match = regex.firstMatch(geminiResponse);
  // レスポンスから不要な文字列を削除
  final cleaned =
      match?.group(1) ??
      ''
          .replaceAll('\n', '')
          .replaceAll(RegExp(r'\\?\"'), '"')
          .replaceAll("'", '"');
  final List<dynamic> jsonList = jsonDecode(cleaned);
  return jsonList.map<TrainingMenu>((item) {
    final menu = item['menu'] as String?;
    final rest = item['rest'] as int?;
    final weight = item['weight'] as int?;
    final reps = item['reps'] as int?;

    return TrainingMenu(
      trainPart: trainPart,
      menu: menu ?? '',
      rest: rest ?? 60,
      weight: weight ?? 100,
      reps: reps ?? 10,
    );
  }).toList();
}
