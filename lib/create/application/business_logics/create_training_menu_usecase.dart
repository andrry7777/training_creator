import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/create/infrastructure/repository/create_training_menu_repository_impl.dart';

part 'create_training_menu_usecase.g.dart';

@riverpod
class CreateTrainingMenuUseCase extends _$CreateTrainingMenuUseCase {
  @override
  AsyncValue<List<TrainingMenu>> build() => AsyncValue.data([]);

  Future<void> createMenu({
    required TrainPart trainPart,
    required String trainTime,
    required String strength,
    required String fatigue,
  }) async {
    final repository = ref.read(trainingMenuRepositoryProvider);
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
    state = AsyncValue.data(trainingMenus);
  }
}
