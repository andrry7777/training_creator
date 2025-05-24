import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/create/domain/repositoryies/interface_create_menu_repository.dart';
import 'package:train_menu_creator/create/infrastructure/repository/create_training_menu_repository_impl.dart';

final createTrainingMenuUseCaseProvider = Provider<CreateTrainingMenuUseCase>((
  ref,
) {
  final repository = ref.read(trainingMenuRepositoryProvider);
  return CreateTrainingMenuUseCase(repository: repository);
});

class CreateTrainingMenuUseCase {
  CreateTrainingMenuUseCase({required this.repository});

  final CreateMenuRepository repository;

  Future<List<TrainingMenu>> createMenu({
    required TrainPart trainPart,
    required String trainTime,
    required String strength,
    required String fatigue,
  }) async {
    final geminiResponse = await repository.createTrainingMenuByGemini(
      trainPart: trainPart,
      trainTime: trainTime,
      strength: strength,
      fatigue: fatigue,
    );
    final trainingMenus = convertGeminiResponseToTrainingMenu(
      geminiResponse.candidates[0].content.parts[0].text,
      trainPart,
    );
    return trainingMenus;
  }
}
