import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:train_menu_creator/workout/infrastructure/model/GeminiResponse.dart';
import 'package:http/http.dart' as http show post;

class GeminiDataSource {
  Future<GeminiResponseModel> fetchGeminiAnswer({
    required Uri url,
    required String prompt,
  }) async {
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          },
        ],
      }),
    );
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final geminiResponse = GeminiResponseModel.fromJson(json);
      return geminiResponse;
    } else {
      throw Exception('Gemini APIリクエスト失敗: ${res.body}');
    }
  }
}

final geminiDataSourceProvider = Provider<GeminiDataSource>((ref) {
  return GeminiDataSource();
});