import 'package:go_router/go_router.dart';
import 'package:train_menu_creator/app/router/route_names.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/create/presentation/pages/make_training_menu_screen.dart';
import 'package:train_menu_creator/create/presentation/pages/select_part_screen.dart';
import 'package:train_menu_creator/workout/presentation/workout_screen.dart';

final myAppRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SelectPartScreen()),
    GoRoute(
      path: RouteNames.createMenu,
      builder: (context, state) {
        final args = state.extra as TrainPart?;
        return QuestionPage(trainPart: args ?? TrainPart.other);
      },
    ),
    GoRoute(
      path: RouteNames.workout,
      builder: (context, state) => const WorkoutScreen(),
    ),
  ],
);
