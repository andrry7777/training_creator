import 'package:flutter/material.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';

class WorkoutComplete extends StatelessWidget {
  const WorkoutComplete({
    required this.archive,
    required this.onRestart,
    Key? key,
  }) : super(key: key);

  final List<TrainingMenu> archive;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'トレーニング完了！',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: archive.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, i) {
                final m = archive[i];
                return ListTile(
                  leading: Icon(m.trainPart.icon, color: Colors.teal),
                  title: Text(m.menu),
                  subtitle: Text('${m.weight}kg × ${m.reps}回'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
