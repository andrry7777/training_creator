import 'package:go_router/go_router.dart';
import 'package:train_menu_creator/app/router/route_names.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/create/presentation/pages/make_training_menu_screen.dart';
import 'package:train_menu_creator/create/presentation/pages/settings_screen.dart';
import 'package:train_menu_creator/home/presentation/home_screen.dart';
import 'package:train_menu_creator/workout/presentation/workout_screen.dart';

final myAppRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const TrainingHomeScreen()),
    GoRoute(
      path: RouteNames.createMenu,
      builder: (context, state) {
        return QuestionPage();
      },
    ),
    GoRoute(
      path: RouteNames.workout,
      builder: (context, state) {
        final argsMap = state.extra as Map<String, dynamic>;
        final trainPart = argsMap['trainPart'] as List<TrainPart>;
        final trainTime = argsMap['trainTime'] as String;
        final strength = argsMap['strength'] as String;
        final fatigue = argsMap['fatigue'] as String;
        return WorkoutApp(
          trainPart: trainPart,
          trainTime: trainTime,
          strength: strength,
          fatigue: fatigue,
        );
      },
    ),
    GoRoute(
      path: RouteNames.settings,
      builder: (context, stata) => FitnessSettings(),
    ),
    GoRoute(
      path: RouteNames.home,
      builder: (context, stata) => TrainingHomeScreen(),
    ),
  ],
);
