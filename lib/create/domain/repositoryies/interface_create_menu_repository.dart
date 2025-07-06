import 'package:train_menu_creator/create/domain/entity/user_settings.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/create/infrastructure/model/gemini_response.dart';

abstract class CreateMenuRepository {
  Future<GeminiResponseModel> createTrainingMenuByGemini({
    required List<TrainPart> trainPart,
    required String trainTime,
    required String strength,
    required String fatigue,
    required UserSettings settings,
  });
}
