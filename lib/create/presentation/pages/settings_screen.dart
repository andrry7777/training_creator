import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/create/domain/constants/create_training_settings_constans.dart';
import 'package:train_menu_creator/create/presentation/view_model/create_setting_screen_view_model.dart';
import 'package:train_menu_creator/create/presentation/widgets/settings_card.dart';

class FitnessSettings extends HookConsumerWidget {
  const FitnessSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// todo: 初期表示はspから取得させる様に改修
    final controller = ref.read(settingScreenProvider.notifier);
    final frequency = useState('週3回');
    final intensity = useState('中級者');
    final objection = useState('筋肥大');
    final age = useState<double>(25);
    final weight = useState<double>(70);
    final height = useState<double>(170);
    final environment = useState('ジム');
    final gender = useState('男性');
    return Scaffold(
      appBar: AppBar(title: const Text('フィットネス設定')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'トレーニング情報',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SettingsCard(
            title: 'トレーニングの目的',
            icon: Icons.abc,
            value: objection.value,
            onTap:
                () => _showEditModal(
                  SettingEditPicker(
                    title: 'トレーニングの目的',
                    options: trainingObjectionOptions,
                    selectedValue: objection.value,
                    onChanged: (v) {
                      objection.value = v;
                      controller.saveSetting(objection: v);
                    },
                  ),
                  context,
                ),
          ),
          SettingsCard(
            title: 'トレーニング頻度',
            icon: Icons.calendar_today,
            value: frequency.value,
            onTap:
                () => _showEditModal(
                  SettingEditPicker(
                    title: 'トレーニング頻度',
                    options: frequencyOptions,
                    selectedValue: frequency.value,
                    onChanged: (v) {
                      frequency.value = v;
                      controller.saveSetting(often: v);
                    },
                  ),
                  context,
                ),
          ),
          SettingsCard(
            title: 'トレーニング歴',
            icon: Icons.whatshot,
            value: intensity.value,
            onTap:
                () => _showEditModal(
                  SettingEditPicker(
                    title: 'トレーニング歴',
                    options: trainingIntensityOptions,
                    selectedValue: intensity.value,
                    onChanged: (v) {
                      intensity.value = v;
                      controller.saveSetting(intensity: v);
                    },
                  ),
                  context,
                ),
          ),
          SettingsCard(
            title: 'トレーニング環境',
            icon: Icons.fitness_center,
            value: environment.value,
            onTap:
                () => _showEditModal(
                  TrainingEnvironmentSelector(
                    onSelected: (v) {
                      environment.value = v;
                      controller.saveSetting(environment: v);
                    },
                  ),
                  context,
                ),
          ),
          const SizedBox(height: 24),
          const Text(
            '身体情報',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SettingsCard(
            title: '年齢',
            icon: Icons.lock_clock,
            value: '${age.value.round()}歳',
            onTap:
                () => _showEditModal(
                  SettingEditSlider(
                    initialValue: age.value,
                    onChanged: (v) {
                      age.value = v;
                      controller.saveSetting(age: v.round().toString());
                    },
                    labelText: '年齢:',
                    unit: '歳',
                  ),
                  context,
                ),
          ),
          SettingsCard(
            title: '体重',
            icon: Icons.monitor_weight,
            value: '${weight.value.round()}kg',
            onTap:
                () => _showEditModal(
                  SettingEditSlider(
                    initialValue: weight.value,
                    onChanged: (v) {
                      weight.value = v;
                      controller.saveSetting(weight: v.round().toString());
                    },
                    labelText: '体重:',
                    unit: 'kg',
                  ),
                  context,
                ),
          ),
          SettingsCard(
            title: '身長',
            icon: Icons.height,
            value: '${height.value.round()}cm',
            onTap:
                () => _showEditModal(
                  SettingEditSlider(
                    initialValue: height.value,
                    onChanged: (v) {
                      height.value = v;
                      controller.saveSetting(height: v.round().toString());
                    },
                    labelText: '身長',
                    unit: 'cm',
                  ),
                  context,
                ),
          ),
          SettingsCard(
            title: '性別',
            icon: Icons.person,
            value: gender.value,
            onTap:
                () => _showEditModal(
                  SettingEditPicker(
                    title: '性別',
                    selectedValue: gender.value,
                    onChanged: (v) {
                      gender.value = v;
                      controller.saveSetting(gender: v);
                    },
                    options: genderOptions,
                  ),
                  context,
                ),
          ),
        ],
      ),
    );
  }
}

/// モーダル表示用のヘルパー
Future<void> _showEditModal(Widget child, BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => Padding(padding: const EdgeInsets.all(16), child: child),
  );
}

class SettingEditPicker extends StatelessWidget {
  const SettingEditPicker({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.options,
    required this.title,
  });

  final String selectedValue;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...options.map(
          (option) => ListTile(
            title: Text(option),
            trailing: selectedValue == option ? const Icon(Icons.check) : null,
            onTap: () {
              onChanged(option);
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("キャンセル"),
        ),
      ],
    );
  }
}

class SettingEditSlider extends StatelessWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;
  final String labelText;
  final String unit;

  const SettingEditSlider({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.labelText,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    double value = initialValue;

    return StatefulBuilder(
      builder:
          (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$labelText ${value.round()} $unit',
                style: const TextStyle(fontSize: 18),
              ),
              Slider(
                value: value,
                min: initialValue - 30,
                max: initialValue + 30,
                label: '${value.round()} $unit',
                onChanged: (v) => setState(() => value = v),
              ),
              ElevatedButton(
                onPressed: () {
                  onChanged(value);
                  Navigator.pop(context);
                },
                child: const Text('保存'),
              ),
            ],
          ),
    );
  }
}

class TrainingEnvironmentSelector extends StatelessWidget {
  final Function(String) onSelected;

  const TrainingEnvironmentSelector({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'トレーニング環境は？',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(
                context,
                label: 'ジム',
                icon: Icons.sports_gymnastics,
                onTap: () => onSelected('ジム'),
              ),
              _buildOption(
                context,
                label: '自宅',
                icon: Icons.home,
                onTap: () => onSelected('自宅'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Icon(icon, size: 36, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
