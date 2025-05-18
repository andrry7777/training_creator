import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/create/application/business_logics/create_training_menu_usecase.dart';

class WorkoutScreen extends HookConsumerWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingMenus = ref.watch(createTrainingMenuUseCaseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("トレーニングメニュー一覧")),
      body: ListView.separated(
        itemCount: 1,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('a'),
            subtitle: Text(
              '重量: 1kg / 回数: .reps}回 / 休憩: {formatSeconds(menu.rest)}',
            ),
            leading: Icon(Icons.fitness_center),
          );
        },
      ),
    );
  }
}
