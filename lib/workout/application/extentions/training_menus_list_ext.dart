import 'package:train_menu_creator/create/domain/entity/training_menus_for_hive.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/util/date_time_helper.dart';

extension TrainingListExt on List<TrainingMenuForHive> {
  List<String> get lastTrainPart {
    if (isEmpty) return [];
    final lastTrainingDay = normalizeDate(last.createdAt);
    final matchingItems = where(
      (item) => normalizeDate(item.createdAt) == lastTrainingDay,
    );
    final lastPartInts =
        matchingItems.map((item) => item.trainPartInt).toSet().toList();
    return lastPartInts
        .map((e) => getTrainPartFromInt(e).getStringName)
        .toList();
  }

  int getTrainDaysTargetMonth(DateTime date) {
    final matchingItems = where(
      (item) =>
          item.createdAt.year == date.year &&
          item.createdAt.month == date.month,
    );
    final trainingDaysList = matchingItems.map((e) => e.createdAt).toList();
    return trainingDaysList
        .map((e) => DateTime(e.year, e.month))
        .toSet()
        .length;
  }

  int getTotalWeightTargetMonth(DateTime date) {
    final matchingItems = where(
      (item) =>
          item.createdAt.year == date.year &&
          item.createdAt.month == date.month,
    );
    return matchingItems.fold(0, (prev, e) => prev + (e.weight * e.reps));
  }

  int get getOverAllWeight {
    return fold(0, (prev, e) => prev + (e.weight * e.reps));
  }

  double getFrequencies(TrainPart trainPart) {
    final target = [];
    for (final record in this) {
      final hasTargetPart = record.trainPartInt == trainPart.getTrainPartInt;
      if (hasTargetPart) target.add(record);
    }
    return target.length / length;
  }

  List<TrainingMenuForHive> getThirtyDaysRecord(DateTime time) {
    final thirtyDaysAgo = time.subtract(const Duration(days: 30));
    return where((record) => record.createdAt.isAfter(thirtyDaysAgo)).toList();
  }
}
