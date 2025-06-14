import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:train_menu_creator/create/infrastructure/model/gemini_response.dart';

final geminiApiClientProvider = Provider<GeminiApiClient>(
  (ref) => GeminiApiClient(),
);

class GeminiApiClient {
  Future<GeminiResponseModel> fetchGeminiAnswer({
    required String prompt,
  }) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
    );
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
      debugPrint(json.toString());
      final geminiResponse = GeminiResponseModel.fromJson(json);
      return geminiResponse;
    } else {
      throw Exception('Gemini APIリクエスト失敗: ${res.body}');
    }
  }
}
