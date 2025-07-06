import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus_for_hive.dart';

part 'home_screen_view_model.freezed.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeScreenViewModel, HomeScreenState>((ref) {
      return HomeScreenViewModel();
    });

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    @Default([]) List<TrainingMenuForHive> trainingRecords,
  }) = _HomeScreenState;
}

class HomeScreenViewModel extends StateNotifier<HomeScreenState> {
  HomeScreenViewModel() : super(HomeScreenState());

  Future<void> getTrainingRecords() async {
    final box = await Hive.openBox<TrainingMenuForHive>('training_menu');
    state = state.copyWith(trainingRecords: box.values.toList());
  }
}
