import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/workout/presentation/view_model/work_out_screen_viewmodel.dart';

class WorkoutScreen extends HookConsumerWidget {
  const WorkoutScreen({
    super.key,
    required this.trainPart,
    required this.trainTime,
    required this.fatigue,
    required this.strength,
  });

  final List<TrainPart> trainPart;
  final String trainTime;
  final String fatigue;
  final String strength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(workOutViewModelProvider);
    final controller = ref.read(workOutViewModelProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.createMenu(
          trainPart: trainPart,
          trainTime: trainTime,
          fatigue: fatigue,
          strength: strength,
        );
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF9A8B), Color(0xFFFF6A88), Color(0xFFFF99AC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Text(
                  '今日も頑張りましょう！',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: viewModel.remainMenu.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (err, stack) => Center(
                        child: Text(
                          'エラーが発生しました: $err',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                  data: (menus) {
                    if (menus.isEmpty) {
                      return const Center(
                        child: Text(
                          'メニューが見つかりませんでした',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: menus.length,
                      itemBuilder: (context, index) {
                        final menu = menus[index];

                        return Dismissible(
                          key: ValueKey('${menu.menu}_${menu.id}'),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            controller.setMenuAsDone(id: menu.id);
                          },
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.shade400,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 3,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menu.menu,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '重量: ${menu.weight}kg\n回数: ${menu.reps}回\n休憩: ${menu.rest}秒',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
