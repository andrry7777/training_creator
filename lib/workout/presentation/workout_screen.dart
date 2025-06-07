import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/workout/presentation/view_model/work_out_screen_viewmodel.dart';
import 'package:train_menu_creator/workout/presentation/work_out_complite_screen.dart';

class WorkoutApp extends HookConsumerWidget {
  const WorkoutApp({
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

    final currentIndex = useState(0);
    final isResting = useState(false);
    final restTime = useState(0);
    final isCompleted = useState(false);
    final executed = useState<List<TrainingMenu>>([]);

    final menus = viewModel.remainMenu.value ?? [];

    final nextScrollController = useScrollController();

    // Prevent out-of-range index when menus list shrinks
    final safeIndex =
        menus.isNotEmpty ? currentIndex.value.clamp(0, menus.length - 1) : 0;

    useEffect(() {
      if (menus.isNotEmpty) {
        // Estimate item width plus separator (adjust if necessary)
        const itemWidth = 100.0;
        const separatorWidth = 8.0;
        final offset = (itemWidth + separatorWidth) * safeIndex;
        nextScrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      return null;
    }, [safeIndex]);

    void handleNext() {
      executed.value = [...executed.value, menus[currentIndex.value]];
      isResting.value = false;
      controller.setMenuAsDone(id: menus[currentIndex.value].id);
      if (currentIndex.value < menus.length - 1) {
        currentIndex.value++;
      } else {
        isCompleted.value = true;
      }
    }

    void handleComplete() {
      if (isResting.value) return;
      isResting.value = true;
      restTime.value = menus[currentIndex.value].rest;
      Timer.periodic(const Duration(seconds: 1), (t) {
        if (restTime.value <= 0) {
          t.cancel();
          handleNext();
        } else {
          restTime.value--;
        }
      });
    }

    void handleSkip() {
      isResting.value = false;
      if (currentIndex.value < menus.length - 1) {
        currentIndex.value++;
      }
    }

    if (isCompleted.value) {
      return Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: const _WorkoutAppBar(),
        body: SafeArea(
          child: Container(
            color: Colors.grey.shade900,
            child: WorkoutComplete(
              archive: executed.value,
              onRestart: () {
                // Reset all state for a new session
                currentIndex.value = 0;
                isResting.value = false;
                restTime.value = 0;
                executed.value = [];
                isCompleted.value = false;
              },
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: const _WorkoutAppBar(),
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade900,
          child:
              menus.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _NextQueue(
                          menus: menus,
                          currentIndex: safeIndex,
                          scrollController: nextScrollController,
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child:
                              isResting.value
                                  ? RestTimer(
                                    duration: restTime.value,
                                    onFinish: handleNext,
                                  )
                                  : _MenuDetail(menus[safeIndex]),
                        ),
                        _ControlPanel(
                          onSkip: handleSkip,
                          onComplete: handleComplete,
                          isResting: isResting.value,
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}

class _WorkoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _WorkoutAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
    title: const Text('トレーニングメニュー', style: TextStyle(color: Colors.white)),
    centerTitle: true,
    backgroundColor: Colors.grey.shade800,
    elevation: 0,
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MenuDetail extends StatelessWidget {
  final TrainingMenu menu;
  final String? gifUrl;

  const _MenuDetail(this.menu, {this.gifUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (gifUrl != null && gifUrl!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Image.network(gifUrl!, height: 150, fit: BoxFit.contain),
          ),
        const SizedBox(height: 8),
        Text(
          menu.menu,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _InfoBox(label: '重量', value: '${menu.weight}kg'),
            const SizedBox(width: 16),
            _InfoBox(label: '回数', value: '${menu.reps}回'),
          ],
        ),
      ],
    );
  }
}

class _ControlPanel extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onComplete;
  final bool isResting;

  const _ControlPanel({
    required this.onSkip,
    required this.onComplete,
    required this.isResting,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: isResting ? null : onSkip,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isResting ? Colors.grey.shade700 : Colors.grey.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('スキップ', style: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: isResting ? null : onComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isResting ? Colors.grey.shade700 : Colors.orange.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('完了', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutPlan {
  final String title;
  final List<Exercise> exercises;

  WorkoutPlan({required this.title, required this.exercises});

  WorkoutPlan copy() => WorkoutPlan(
    title: title,
    exercises: exercises.map((e) => e.copy()).toList(),
  );
}

class Exercise {
  final String name;
  final List<SetInfo> sets;
  final int rest;
  bool completed = false;
  final String id;

  Exercise({
    required this.name,
    required this.sets,
    required this.rest,
    required this.id,
  });

  Exercise copy() => Exercise(
    name: name,
    sets: sets.map((s) => s.copy()).toList(),
    rest: rest,
    id: id,
  );
}

class SetInfo {
  final int weight, reps;

  SetInfo(this.weight, this.reps);

  SetInfo copy() => SetInfo(weight, reps);
}

class RestTimer extends StatelessWidget {
  final int duration;
  final VoidCallback onFinish;

  const RestTimer({required this.duration, required this.onFinish, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    final progress = 1 - duration / (duration == 0 ? 1 : duration);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('休憩中…', style: TextStyle(color: Colors.white, fontSize: 20)),
        const SizedBox(height: 16),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 12,
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation(Colors.deepOrangeAccent),
              ),
            ),
            Text(
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: onFinish,
          child: const Text(
            '休憩をスキップ',
            style: TextStyle(color: Colors.deepOrangeAccent),
          ),
        ),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label, value;

  const _InfoBox({required this.label, required this.value, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade800,
          ),
        ),
      ],
    );
  }
}

class _NextQueue extends StatelessWidget {
  const _NextQueue({
    required this.menus,
    required this.currentIndex,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  final List<TrainingMenu> menus;
  final int currentIndex;
  final ScrollController scrollController;

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
          child: ListView.separated(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: menus.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final menu = menus[i];
              final isCurrent = i == currentIndex;
              return Container(
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
                            isCurrent ? Colors.orange.shade300 : Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
