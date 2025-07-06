import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:train_menu_creator/create//infrastructure/api_client/gemini_api_client.dart';
import 'package:train_menu_creator/create/domain/entity/user_settings.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/create/domain/repositoryies/interface_create_menu_repository.dart';
import 'package:train_menu_creator/create/infrastructure/model/gemini_response.dart';

final trainingMenuRepositoryProvider = Provider<CreateMenuRepository>((ref) {
  final apiClient = ref.read(geminiApiClientProvider);
  return TrainingMenuRepositoryImpl(geminiApiClient: apiClient);
});

class TrainingMenuRepositoryImpl implements CreateMenuRepository {
  const TrainingMenuRepositoryImpl({required this.geminiApiClient});

  final GeminiApiClient geminiApiClient;

  @override
  Future<GeminiResponseModel> createTrainingMenuByGemini({
    required List<TrainPart> trainPart,
    required String trainTime,
    required String strength,
    required String fatigue,
    required UserSettings settings,
  }) async {
    final prompt = '''
あなたは優秀なパーソナルトレーナーです。
以下の条件に合った本日のトレーニングメニューを提案してください。

鍛えたい部位: ${trainPart.map((e) => e.getStringName)}
強度：$strength
トレーニング時間：$trainTime
コンディション：$fatigue
トレーニングの目的：${settings.objection}
トレーニング歴：${settings.intensity}
トレーニング環境：${settings.trainingEnvironment}
トレーニング頻度：${settings.often}

性別：${settings.sex}
年齢：${settings.age}
体重：${settings.weight}
身長：${settings.height}

レスポンスの形式は  
[
{
 "part": "トレーニング部位",
 "menu": "トレーニングメニュー名",
 "advice": "トレーニング実施におけるアドバイス",
 "rest": 休憩時間,
 "weight": トレーニング重量,
 "reps": トレーニング回数
},
{
 "part": "トレーニング部位",
 "menu": "トレーニングメニュー名",
 "advice": "トレーニング実施におけるアドバイス",
 "rest": 休憩時間,
 "weight": トレーニング重量,
 "reps": トレーニング回数
},
{
 "part": "トレーニング部位",
 "menu": "トレーニングメニュー名",
 "advice": "トレーニング実施におけるアドバイス",
 "rest": 休憩時間,
 "weight": トレーニング重量,
 "reps": トレーニング回数
},
...
]
の様な形で、本日実施すべきトレーニングをオブジェクトの配列形式として教えてください。
尚、回答は以下の要件を満たしてください。
・回答は具体的な値でお願いします。
・それぞれ文献などをもとに値を設定してください。
・改行文字は不要です。
・休憩時間は秒単位で記載してください。
・数値を返却する項目に関して、単位は返却不要です。また、整数で値を返却してください。
・同一トレーニングメニューを複数セット実施する際は複数個のオブジェクトに分けて記載してください
・上記形式を満たさない返却値は不要です
・最後のオブジェクトの末尾には,は不要です
・トレーニング部位に関しては 胸, 肩, 脚, 背中, 腕, その他, のいずれかで返却する様にしてください。
''';
    debugPrint(prompt);
    final response = await geminiApiClient.fetchGeminiAnswer(prompt: prompt);

    return response;
  }
}
