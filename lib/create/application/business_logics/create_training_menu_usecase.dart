import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/create/domain/repositoryies/interface_create_menu_repository.dart';
import 'package:train_menu_creator/create/domain/repositoryies/interface_create_menu_settings.dart';
import 'package:train_menu_creator/create/infrastructure/repository/create_training_menu_repository_impl.dart';
import 'package:train_menu_creator/create/infrastructure/repository/user_setting_repository_impl.dart';

final createTrainingMenuUseCaseProvider = Provider<CreateTrainingMenuUseCase>((
  ref,
) {
  final repository = ref.read(trainingMenuRepositoryProvider);
  final settingsRepository = ref.read(settingRepositoryProvider);
  return CreateTrainingMenuUseCase(
    repository: repository,
    settingsRepository: settingsRepository,
  );
});

class CreateTrainingMenuUseCase {
  CreateTrainingMenuUseCase({
    required this.repository,
    required this.settingsRepository,
  });

  final CreateMenuRepository repository;
  final SettingsOfCreateMenuRepository settingsRepository;

  Future<List<TrainingMenu>> createMenu({
    required List<TrainPart> trainPart,
    required String trainTime,
    required String strength,
    required String fatigue,
  }) async {
    final settings = await settingsRepository.fetchUserSettings();
    final geminiResponse = await repository.createTrainingMenuByGemini(
      trainPart: trainPart,
      trainTime: trainTime,
      strength: strength,
      fatigue: fatigue,
      settings: settings,
    );
    final trainingMenus = convertGeminiResponseToTrainingMenu(
      geminiResponse.candidates[0].content.parts[0].text,
    );
    return trainingMenus;
  }
}
