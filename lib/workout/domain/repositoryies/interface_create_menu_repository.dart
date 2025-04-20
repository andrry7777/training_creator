import 'package:train_menu_creator/workout/domain/enums/train_part_enum.dart';

abstract class CreateMenuRepository{
  Future<String> createTrainingMenuByGemini({
    required TrainPart trainPart,
    required String trainTime,
    required String strength,
    required String fatigue,
});
}