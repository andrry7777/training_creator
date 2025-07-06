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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              expandedHeight: 80,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'フィットネス設定',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: Text(
                          'トレーニング情報',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SettingsCard(
                        title: 'トレーニングの目的',
                        icon: Icons.abc,
                        value: objection.value,
                        iconColor: Colors.orange,
                        titleColor: Colors.white,
                        cardColor: const Color(0xFF1E1E1E),
                        borderColor: const Color(0xFF333333),
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
                      const SizedBox(height: 8),
                      SettingsCard(
                        title: 'トレーニング頻度',
                        icon: Icons.calendar_today,
                        value: frequency.value,
                        iconColor: Colors.orange,
                        titleColor: Colors.white,
                        cardColor: const Color(0xFF1E1E1E),
                        borderColor: const Color(0xFF333333),
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
                      const SizedBox(height: 8),
                      SettingsCard(
                        title: 'トレーニング歴',
                        icon: Icons.whatshot,
                        value: intensity.value,
                        iconColor: Colors.orange,
                        titleColor: Colors.white,
                        cardColor: const Color(0xFF1E1E1E),
                        borderColor: const Color(0xFF333333),
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
                      const SizedBox(height: 8),
                      SettingsCard(
                        title: 'トレーニング環境',
                        icon: Icons.fitness_center,
                        value: environment.value,
                        iconColor: Colors.orange,
                        titleColor: Colors.white,
                        cardColor: const Color(0xFF1E1E1E),
                        borderColor: const Color(0xFF333333),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '身体情報',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SettingsCard(
                        title: '年齢',
                        icon: Icons.lock_clock,
                        value: '${age.value.round()}歳',
                        iconColor: Colors.orange,
                        titleColor: Colors.white,
                        cardColor: const Color(0xFF1E1E1E),
                        borderColor: const Color(0xFF333333),
                        onTap:
                            () => _showEditModal(
                              SettingEditSlider(
                                initialValue: age.value,
                                onChanged: (v) {
                                  age.value = v;
                                  controller.saveSetting(
                                    age: v.round().toString(),
                                  );
                                },
                                labelText: '年齢:',
                                unit: '歳',
                              ),
                              context,
                            ),
                      ),
                      const SizedBox(height: 8),
                      SettingsCard(
                        title: '体重',
                        icon: Icons.monitor_weight,
                        value: '${weight.value.round()}kg',
                        iconColor: Colors.orange,
                        titleColor: Colors.white,
                        cardColor: const Color(0xFF1E1E1E),
                        borderColor: const Color(0xFF333333),
                        onTap:
                            () => _showEditModal(
                              SettingEditSlider(
                                initialValue: weight.value,
                                onChanged: (v) {
                                  weight.value = v;
                                  controller.saveSetting(
                                    weight: v.round().toString(),
                                  );
                                },
                                labelText: '体重:',
                                unit: 'kg',
                              ),
                              context,
                            ),
                      ),
                      const SizedBox(height: 8),
                      SettingsCard(
                        title: '身長',
                        icon: Icons.height,
                        value: '${height.value.round()}cm',
                        iconColor: Colors.orange,
                        titleColor: Colors.white,
                        cardColor: const Color(0xFF1E1E1E),
                        borderColor: const Color(0xFF333333),
                        onTap:
                            () => _showEditModal(
                              SettingEditSlider(
                                initialValue: height.value,
                                onChanged: (v) {
                                  height.value = v;
                                  controller.saveSetting(
                                    height: v.round().toString(),
                                  );
                                },
                                labelText: '身長',
                                unit: 'cm',
                              ),
                              context,
                            ),
                      ),
                      const SizedBox(height: 8),
                      SettingsCard(
                        title: '性別',
                        icon: Icons.person,
                        value: gender.value,
                        iconColor: Colors.orange,
                        titleColor: Colors.white,
                        cardColor: const Color(0xFF1E1E1E),
                        borderColor: const Color(0xFF333333),
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
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

/// モーダル表示用のヘルパー
Future<void> _showEditModal(Widget child, BuildContext context) async {
  // Use a bright, light tone for the modal background for clarity
  final backgroundColor = const Color(0xFFFFFFFF);
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (_) => Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Theme(
              data: Theme.of(context).copyWith(
                textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.black87,
                  displayColor: Colors.black87,
                ),
              ),
              child: child,
            ),
          ),
        ),
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...options.map(
          (option) => ListTile(
            title: Text(option, style: const TextStyle(color: Colors.black87)),
            trailing:
                selectedValue == option
                    ? const Icon(Icons.check, color: Colors.black87)
                    : null,
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
