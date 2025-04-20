import 'package:http/http.dart' as http show post;
import 'package:train_menu_creator/workout/domain/enums/train_part_enum.dart';
import 'dart:convert';

import 'package:train_menu_creator/workout/domain/repositoryies/interface_create_menu_repository.dart';

class TrainingMenuRepositoryImpl implements CreateMenuRepository {
  const TrainingMenuRepositoryImpl();

  @override
  Future<String> createTrainingMenuByGemini({
    required TrainPart trainPart,
    required String trainTime,
    required String strength,
    required String fatigue,
  }) async {
    final prompt = '''
あなたは優秀なパーソナルトレーナーです。
以下の条件に合った本日のトレーニングメニューを5種目程度、わかりやすく提案してください。

鍛えたい部位: ${trainPart.getStringName}
強度：$strength
トレーニング時間：$trainTime
コンディション：$fatigue

形式は「種目名 - セット数 x 回数」のように簡潔に記述してください。
尚、上記形式を満たさない返却値は不要です。
''';

    final apiKey = 'AIzaSyAxsOKUiNX4CRB8ZN1geX6cGNC00S4prAc';
    final response = await http.post(
      Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key$_apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final candidates = json['candidates'] as List?;
      if (candidates != null && candidates.isNotEmpty) {
        return candidates[0]['content']['parts'][0]['text'] as String;
      } else {
        throw Exception('Gemini APIの応答に候補が含まれていません。');
      }
    } else {
      throw Exception('Gemini APIリクエスト失敗: ${response.body}');
    }
  }
}