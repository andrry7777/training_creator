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
  }) = _WorkOutScreenState;
}

class WorkOutViewModel extends StateNotifier<WorkOutScreenState> {
  WorkOutViewModel({required this.createUseCase, required this.workOutUseCase})
    : super(const WorkOutScreenState());

  final CreateTrainingMenuUseCase createUseCase;
  final WorkOutUseCase workOutUseCase;

  void createMenu({
    required TrainPart trainPart,
    required String trainTime,
    required String strength,
    required String fatigue,
  }) async {
    state = state.copyWith(remainMenu: AsyncValue.loading());
    final result = await createUseCase.createMenu(
      trainPart: trainPart,
      trainTime: trainTime,
      strength: strength,
      fatigue: fatigue,
    );
    state = state.copyWith(remainMenu: AsyncValue.data(result));
  }

  void setMenuAsDone({required String id}) {
    final remain = workOutUseCase.markTrainingDone(
      id: id,
      trainingMenus: state.remainMenu,
    );
    state = state.copyWith(remainMenu: remain);
  }
}
