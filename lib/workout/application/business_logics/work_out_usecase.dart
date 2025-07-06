import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus_for_hive.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/util/timer_manager.dart';

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

  AsyncValue<List<TrainingMenu>> moveSameNamedMenusToEnd({
    required String id,
    required AsyncValue<List<TrainingMenu>> trainingMenus,
  }) {
    final menus = trainingMenus.value ?? [];
    final target = menus.firstWhere((m) => m.id == id);
    final name = target.menu;
    final toMove = menus.where((m) => m.menu == name).toList();
    final remaining = menus.where((m) => m.menu != name).toList();

    return AsyncValue.data([...remaining, ...toMove]);
  }

  void startTimer({
    required int seconds,
    required VoidCallback onCompleted,
    required ValueChanged<int> onTick,
  }) {
    final timer = TimerManager();
    timer.start(seconds: seconds, onTick: onTick, onComplete: onCompleted);
  }

  void canselTimer() {
    final timer = TimerManager();
    timer.cancel();
  }
}
