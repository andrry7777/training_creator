import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus_for_hive.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';

final workOutUseCaseProvider = Provider<WorkOutUseCase>(
  (ref) => WorkOutUseCase(),
);

class WorkOutUseCase {
  const WorkOutUseCase();

  AsyncValue<List<TrainingMenu>> markTrainingDone({
    required String id,
    required AsyncValue<List<TrainingMenu>> trainingMenus,
  }) {
    return trainingMenus.when(
      data: (menu) {
        debugPrint(id);
        debugPrint(menu.toString());

        final trainingOfDone = menu.firstWhere((e) => e.id == id);

        /// remove menu of done
        menu.removeWhere((element) => element.id == id);

        final trainingForHive = TrainingMenuForHive(
          trainPartInt: trainingOfDone.trainPart.getTrainPartInt,
          menu: trainingOfDone.menu,
          rest: trainingOfDone.rest,
          weight: trainingOfDone.weight,
          reps: trainingOfDone.reps,
          id: id,
          createdAt: DateTime.now(),
        );

        /// save local
        _saveTrainingToHive(trainingMenu: trainingForHive);
        return trainingMenus;
      },
      error: (e, s) => trainingMenus,
      loading: () => trainingMenus,
    );
  }

  Future<void> _saveTrainingToHive({
    required TrainingMenuForHive trainingMenu,
  }) async {
    final box = await Hive.openBox<TrainingMenuForHive>('training_menu');
    box.add(trainingMenu);
  }
}
