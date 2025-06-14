import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/app/router/route_names.dart';

class TrainingHomeScreen extends HookConsumerWidget {
  const TrainingHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = useState(0);
    final period = useState('month');

    final overviewData = {
      'week': {'time': 5, 'calories': 1800, 'days': 3},
      'month': {'time': 25, 'calories': 8500, 'days': 15},
      'year': {'time': 150, 'calories': 51000, 'days': 90},
    };
    final data = overviewData[period.value]!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'こんにちは、ユーザーさん',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '素晴らしい継続力ですね！',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Icon(Icons.settings, color: Colors.grey),
                    ],
                  ),
                ),
                // Today Card
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF333333)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '今日のトレーニング',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            onPressed: () {
                              context.go(RouteNames.createMenu);
                            },
                            child: const Text(
                              'メニュー作成',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Tabs
                const Text(
                  'ダッシュボード',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ここではあなたのトレーニングの成果を様々な角度から確認できます。',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Row(
                  children:
                      ['概要', '成長', '実績']
                          .asMap()
                          .entries
                          .map(
                            (e) => Expanded(
                              child: GestureDetector(
                                onTap: () => tabIndex.value = e.key,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            tabIndex.value == e.key
                                                ? Colors.orange
                                                : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    e.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          tabIndex.value == e.key
                                              ? Colors.orange
                                              : Colors.grey,
                                      fontWeight:
                                          tabIndex.value == e.key
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 16),
                // Content
                if (tabIndex.value == 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        ['week', 'month', 'year']
                            .map(
                              (p) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ChoiceChip(
                                  label: Text(
                                    p == 'week'
                                        ? '今週'
                                        : p == 'month'
                                        ? '今月'
                                        : '今年',
                                  ),
                                  selected: period.value == p,
                                  onSelected: (_) => period.value = p,
                                  selectedColor: Colors.orange,
                                  backgroundColor: Colors.grey[800],
                                  labelStyle: TextStyle(
                                    color:
                                        period.value == p
                                            ? Colors.white
                                            : Colors.grey[300],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _SummaryCard(
                        icon: Icons.local_fire_department,
                        title: '総トレーニング時間',
                        value: '${data['time']} 時間',
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(width: 8),
                      _SummaryCard(
                        icon: Icons.calendar_month,
                        title: 'トレーニング日数',
                        value: '${data['days']} 日',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _HeatmapCalendar(),
                ] else if (tabIndex.value == 1) ...[
                  _RadarChart(),
                  const SizedBox(height: 16),
                  _LineChart(),
                ] else ...[
                  const Text(
                    'アチーブメント/アクティビティ一覧（仮）',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF333333)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.orange, size: 28),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeatmapCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement heatmap calendar widget
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: const Center(
        child: Text('カレンダー（仮）', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _RadarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement radar chart using fl_chart
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: const Center(
        child: Text('Radar Chart（仮）', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement line chart using fl_chart
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: const Center(
        child: Text('Line Chart（仮）', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
