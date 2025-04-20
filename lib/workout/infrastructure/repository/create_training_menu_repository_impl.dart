import 'package:http/http.dart' as http show post;
import 'package:train_menu_creator/workout/domain/enums/train_part_enum.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:train_menu_creator/workout/domain/repositoryies/interface_create_menu_repository.dart';
import 'package:train_menu_creator/workout/infrastructure/model/GeminiResponse.dart';

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

    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    final response = await http.post(
      Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key$apiKey'),
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
      final geminiResponse = GeminiResponseModel.fromJson(json);
      final rawText = geminiResponse.candidates.first.content.parts.first.text;
      if (rawText.isNotEmpty) {
        return rawText;
      } else {
        throw Exception('Gemini APIの応答に候補が含まれていません。');
      }
    } else {
      throw Exception('Gemini APIリクエスト失敗: ${response.body}');
    }
  }
}