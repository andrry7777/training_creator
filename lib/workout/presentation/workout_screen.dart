import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/workout/presentation/menu_detail.dart';
import 'package:train_menu_creator/workout/presentation/rest_timer.dart';
import 'package:train_menu_creator/workout/presentation/view_model/work_out_screen_viewmodel.dart';
import 'package:train_menu_creator/workout/presentation/work_out_complite_screen.dart';

class WorkoutApp extends HookConsumerWidget {
  const WorkoutApp({
    super.key,
    required this.trainPart,
    required this.trainTime,
    required this.strength,
    required this.fatigue,
  });

  final List<TrainPart> trainPart;
  final String trainTime;
  final String strength;
  final String fatigue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(workOutViewModelProvider.notifier)
            .createMenu(
              trainPart: trainPart,
              trainTime: trainTime,
              fatigue: fatigue,
              strength: strength,
            );
      });
      return null;
    }, []);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: const WorkoutPage(),
    );
  }
}

class WorkoutPage extends HookConsumerWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(workOutViewModelProvider);
    final controller = ref.read(workOutViewModelProvider.notifier);

    final menus = viewModel.remainMenu.value ?? [];

    final nextScrollController = useScrollController();

    // Track if the user has manually scrolled the next queue
    final hasUserScrolled = useState(false);

    // Listen to scroll updates to detect manual user scroll
    useEffect(() {
      void listener() => hasUserScrolled.value = true;
      nextScrollController.addListener(listener);
      return () => nextScrollController.removeListener(listener);
    }, []);

    // Prevent out-of-range index when menus list shrinks
    final safeIndex =
        menus.isNotEmpty
            ? viewModel.currentIndex.clamp(0, menus.length - 1)
            : 0;

    final itemKeys = useMemoized(
      () => List.generate(menus.length, (_) => GlobalKey()),
      [menus.length],
    );

    useEffect(() {
      if (menus.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final context = itemKeys[safeIndex].currentContext;
          if (context != null) {
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 300),
              alignment: 0.0,
            );
            hasUserScrolled.value = false; // reset after auto-scroll
          }
        });
      }
      return null;
    }, [safeIndex]);

    final Widget body;
    if (viewModel.isAllMenuCompleted) {
      body = WorkoutComplete(archive: viewModel.resultToday);
    } else if (menus.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        HapticFeedback.lightImpact();
      });
      body = const Center(child: CircularProgressIndicator());
    } else {
      body = WorkoutBody(
        menus: menus,
        safeIndex: safeIndex,
        scrollController: nextScrollController,
        itemKeys: itemKeys,
        isResting: viewModel.isResting,
        onSkip:
            () => controller.skipCurrentMenu(
              menusLength: menus.length,
              onSkip: (newIndex) => controller.updateCurrentIndex(newIndex),
            ),
        onComplete: () {
          HapticFeedback.heavyImpact();
          controller.startRestTimer();
        },
        onLater:
            () => controller.postponeMenu(
              id: menus[viewModel.currentIndex].id,
              menusLength: menus.length,
              onPostpone: (newIndex) => controller.updateCurrentIndex(newIndex),
            ),
        onFinish: () => controller.handleNext(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B2730), Color(0xFF0F2A3F)],
          ),
        ),
        child: SafeArea(child: body),
      ),
    );
  }
}

class WorkoutBody extends HookWidget {
  const WorkoutBody({
    required this.menus,
    required this.safeIndex,
    required this.scrollController,
    required this.itemKeys,
    required this.isResting,
    required this.onSkip,
    required this.onComplete,
    required this.onLater,
    required this.onFinish,
    super.key,
  });

  final List<TrainingMenu> menus;
  final int safeIndex;
  final ScrollController scrollController;
  final List<GlobalKey> itemKeys;
  final bool isResting;
  final VoidCallback onSkip;
  final VoidCallback onComplete;
  final VoidCallback onLater;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      HapticFeedback.lightImpact();
      return null;
    }, []);
    final currentMenu = menus[safeIndex];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NextQueue(
            menus: menus,
            currentIndex: safeIndex,
            scrollController: scrollController,
            itemKeys: itemKeys,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: RestOrDetail(
              isResting: isResting,
              menu: currentMenu,
              onFinish: onFinish,
            ),
          ),
          const SizedBox(height: 32),
          ControlPanel(
            onSkip: onSkip,
            onComplete: onComplete,
            onLater: onLater,
            isResting: isResting,
          ),
        ],
      ),
    );
  }
}

class RestOrDetail extends HookWidget {
  const RestOrDetail({
    required this.isResting,
    required this.menu,
    required this.onFinish,
    super.key,
  });

  final bool isResting;
  final TrainingMenu menu;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return isResting ? RestTimer(onFinish: onFinish) : MenuDetail(menu);
  }
}

class ControlPanel extends HookWidget {
  const ControlPanel({
    required this.onSkip,
    required this.onComplete,
    required this.onLater,
    required this.isResting,
    super.key,
  });

  final VoidCallback onSkip;
  final VoidCallback onComplete;
  final VoidCallback onLater;
  final bool isResting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isResting ? null : onSkip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800.withOpacity(0.8),
                      foregroundColor: Colors.white70,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('スキップ'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isResting ? null : onLater,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.withOpacity(0.2),
                      foregroundColor: Colors.orange,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('あとで実施'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isResting ? null : onComplete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('完了'),
            ),
          ),
        ],
      ),
    );
  }
}

class NextQueue extends HookWidget {
  const NextQueue({
    required this.menus,
    required this.currentIndex,
    required this.scrollController,
    required this.itemKeys,
    super.key,
  });

  final List<TrainingMenu> menus;
  final int currentIndex;
  final ScrollController scrollController;
  final List<GlobalKey> itemKeys;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '次の種目',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView.separated(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: menus.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final menu = menus[i];
                  final isCurrent = i == currentIndex;
                  return Container(
                    key: itemKeys[i],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isCurrent
                              ? Colors.orange.shade500.withOpacity(0.2)
                              : Colors.grey.shade700.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          menu.trainPart.icon,
                          color:
                              isCurrent
                                  ? Colors.orange.shade400
                                  : Colors.grey.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          menu.menu,
                          style: TextStyle(
                            color:
                                isCurrent
                                    ? Colors.orange.shade300
                                    : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
