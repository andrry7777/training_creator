import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/workout/presentation/controller/training_creation_controller.dart';

class TodayMenuQuestionPage extends HookConsumerWidget {
  final String selectedBodyParts;

  const TodayMenuQuestionPage({super.key, required this.selectedBodyParts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(todayMenuQuestionControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('本日のトレーニング条件')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildSelectedParts(),
            const SizedBox(height: 16),
            _buildDropdown<String>(
              label: '使用できる器具は？',
              value: controller.equipment,
              items: ['自重のみ', 'ダンベルあり', 'ジム設備あり'],
              onChanged: controller.setEquipment,
            ),
            const SizedBox(height: 16),
            _buildDropdown<int>(
              label: 'トレーニングに使える時間は？',
              value: controller.duration,
              items: [15, 30, 45, 60],
              display: (v) => '$v 分',
              onChanged: controller.setDuration,
            ),
            const SizedBox(height: 16),
            _buildDropdown<String>(
              label: '今日の体調・疲労感は？',
              value: controller.fatigue,
              items: ['絶好調', '普通', '少し疲れている', 'かなり疲れている'],
              onChanged: controller.setFatigue,
            ),
            const SizedBox(height: 16),
            _buildDropdown<String>(
              label: 'トレーニング経験レベルは？',
              value: controller.level,
              items: ['初心者', '中級者', '上級者'],
              onChanged: controller.setLevel,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.isValid
                  ? () {
                // 実際の生成ロジックはコントローラに任せる or 遷移など
                controller.generateMenu(selectedBodyParts);
              }
                  : null,
              child: const Text('メニューを生成する'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedParts() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children:[Chip(label: Text(selectedBodyParts))],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    String Function(T)? display,
    required void Function(T?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: const Text('選択してください'),
          items: items
              .map((e) => DropdownMenuItem<T>(
            value: e,
            child: Text(display?.call(e) ?? e.toString()),
          ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}