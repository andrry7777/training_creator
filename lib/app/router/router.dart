import 'package:go_router/go_router.dart';
import 'package:train_menu_creator/app/router/route_names.dart';
import 'package:train_menu_creator/workout/presentation/pages/make_training_menu_screen.dart';
import 'package:train_menu_creator/workout/presentation/pages/select_part_screen.dart';

final myAppRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const SelectPartScreen(),
    ),
    GoRoute(
      path: RouteNames.createMenu,
      builder: (context, state) {
        final part = state.extra as String;
        return TodayMenuQuestionPage(selectedBodyParts: part);
      },
    ),
  ],
);