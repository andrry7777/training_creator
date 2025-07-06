import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';

class WorkoutComplete extends HookConsumerWidget {
  const WorkoutComplete({required this.archive, super.key});

  final List<TrainingMenu> archive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 800),
    )..forward();

    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.emoji_events, size: 64, color: Colors.white),
            const SizedBox(height: 16),
            const Text(
              'トレーニング完了！',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'お疲れ様でした！素晴らしい頑張りです。',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            const Text(
              '実施したトレーニング履歴',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: archive.length,
                itemBuilder: (context, i) {
                  final m = archive[i];
                  return SlideTransition(
                    position: offsetAnimation,
                    child: Card(
                      color: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: Icon(
                          m.trainPart.icon,
                          color: Colors.orange.shade800,
                        ),
                        title: Text(
                          m.menu,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${m.weight}kg × ${m.reps}回',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context.go('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              icon: Icon(Icons.home),
              label: Text('ホームへ戻る'),
            ),
          ],
        ),
      ),
    );
  }
}
