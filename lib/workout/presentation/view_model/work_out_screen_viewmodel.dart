import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:train_menu_creator/create/application/business_logics/create_training_menu_usecase.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/workout/application/business_logics/work_out_usecase.dart';

part 'work_out_screen_viewmodel.freezed.dart';

final workOutViewModelProvider =
    StateNotifierProvider<WorkOutViewModel, WorkOutScreenState>((ref) {
      final createUseCase = ref.watch(createTrainingMenuUseCaseProvider);
      final workOutUseCase = ref.watch(workOutUseCaseProvider);
      return WorkOutViewModel(
        createUseCase: createUseCase,
        workOutUseCase: workOutUseCase,
      );
    });

@freezed
class WorkOutScreenState with _$WorkOutScreenState {
  const factory WorkOutScreenState({
    @Default(AsyncValue.data([])) AsyncValue<List<TrainingMenu>> remainMenu,
    @Default(<TrainingMenu>[]) List<TrainingMenu> resultToday,
    @Default(false) bool isResting,
    @Default(0) int currentIndex,
  }) = _WorkOutScreenState;
}

class WorkOutViewModel extends StateNotifier<WorkOutScreenState> {
  WorkOutViewModel({
    required CreateTrainingMenuUseCase createUseCase,
    required WorkOutUseCase workOutUseCase,
  }) : _workOutUseCase = workOutUseCase,
       _createUseCase = createUseCase,
       super(const WorkOutScreenState());

  final CreateTrainingMenuUseCase _createUseCase;
  final WorkOutUseCase _workOutUseCase;

  Timer? _restTimer;

  void createMenu({
    required List<TrainPart> trainPart,
    required String trainTime,
    required String strength,
    required String fatigue,
  }) async {
    state = state.copyWith(remainMenu: AsyncValue.loading());
    final result = await _createUseCase.createMenu(
      trainPart: trainPart,
      trainTime: trainTime,
      strength: strength,
      fatigue: fatigue,
    );
    state = state.copyWith(remainMenu: AsyncValue.data(result));
  }

  void appendResultToday(TrainingMenu menu) {
    final updated = [...state.resultToday, menu];
    state = state.copyWith(resultToday: updated);
  }

  void setResting(bool value) {
    state = state.copyWith(isResting: value);
  }

  void skipCurrentMenu({
    required int menusLength,
    required void Function(int newIndex) onSkip,
  }) {
    setResting(false);
    final currentIndex = state.currentIndex;
    if (currentIndex < menusLength - 1) {
      onSkip(currentIndex + 1);
    }
  }

  void postponeMenu({
    required String id,
    required int menusLength,
    required void Function(int newIndex) onPostpone,
  }) {
    final result = _workOutUseCase.moveSameNamedMenusToEnd(
      id: id,
      trainingMenus: state.remainMenu,
    );
    state = state.copyWith(remainMenu: result);
    final currentIndex = state.currentIndex;
    if (currentIndex >= menusLength - 1) {
      onPostpone(0);
    }
  }

  void updateCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void handleNext({required VoidCallback onAllCompleted}) {
    final menus = state.remainMenu.value ?? [];

    // append to resultToday
    final updatedResults = [...state.resultToday, menus[state.currentIndex]];
    state = state.copyWith(resultToday: updatedResults);

    // update remainMenu
    final remain = _workOutUseCase.markTrainingDone(
      id: menus[state.currentIndex].id,
      trainingMenus: state.remainMenu,
    );
    state = state.copyWith(remainMenu: remain);

    // check for completion
    if (state.currentIndex >= menus.length - 1) {
      onAllCompleted();
    } else {
      updateCurrentIndex(state.currentIndex + 1);
    }
  }

  void startRestTimer({required VoidCallback onFinished}) {
    if (state.isResting) return;

    final seconds = state.remainMenu.value?[state.currentIndex].rest ?? 0;

    if (seconds <= 0) {
      handleNext(onAllCompleted: onFinished);
      return;
    }

    setResting(true);
    _startCountdown(
      seconds: seconds,
      onCompleted: () {
        setResting(false);
        handleNext(onAllCompleted: onFinished);
      },
    );
  }

  void _startCountdown({
    required int seconds,
    required VoidCallback onCompleted,
  }) {
    int timeLeft = seconds;
    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft <= 0) {
        timer.cancel();
        onCompleted();
      } else {
        timeLeft--;
      }
    });
  }

  @override
  void dispose() {
    _restTimer?.cancel();
    super.dispose();
  }
}
