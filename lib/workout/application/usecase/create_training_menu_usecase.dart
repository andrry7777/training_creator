import 'package:train_menu_creator/workout/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/workout/domain/repositoryies/interface_create_menu_repository.dart';

class CreateTrainingMenuUseCase {
  CreateTrainingMenuUseCase(this._repository);

  final CreateMenuRepository _repository;

  Future<String> createMenu({
    required TrainPart trainPart,
    required String trainTime,
    required String strength,
    required String fatigue,
}) async {
    return await _repository.createTrainingMenuByGemini(
      trainPart: trainPart,
      trainTime: trainTime,
      strength: strength,
      fatigue: fatigue,
    );
  }
}