import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/app/router/route_names.dart';
import 'package:train_menu_creator/home/presentation/component/line_chart.dart';
import 'package:train_menu_creator/home/presentation/component/reder_chart.dart';
import 'package:train_menu_creator/home/presentation/component/training_calender.dart';
import 'package:train_menu_creator/home/presentation/view_model/home_screen_view_model.dart';
import 'package:train_menu_creator/workout/application/extentions/training_menus_list_ext.dart';

class TrainingHomeScreen extends HookConsumerWidget {
  const TrainingHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = useState(0);
    final state = ref.watch(homeViewModelProvider);
    final controller = ref.read(homeViewModelProvider.notifier);

    useEffect(() {
      controller.getTrainingRecords();
      return null;
    }, []);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
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
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '前回のトレーニング',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.trainingRecords.lastTrainPart.join(','),
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
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
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final spacing = 12.0;
                      final cardCount = 3;
                      final cardWidth =
                          (constraints.maxWidth - spacing * (cardCount - 1)) /
                          cardCount;
                      final cardHeight = 110.0;

                      return Row(
                        children: [
                          SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: _SummaryCard(
                              icon: Icons.local_fire_department,
                              title: '今月の重量',
                              union: 'kg',
                              value:
                                  state.trainingRecords
                                      .getTotalWeightTargetMonth(DateTime.now())
                                      .toString(),
                            ),
                          ),
                          SizedBox(width: spacing),
                          SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: _SummaryCard(
                              icon: Icons.calendar_month,
                              title: '日数',
                              union: '日',
                              value:
                                  '${state.trainingRecords.getTrainDaysTargetMonth(DateTime.now())}',
                            ),
                          ),
                          SizedBox(width: spacing),
                          SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: _SummaryCard(
                              icon: Icons.local_fire_department,
                              title: '総重量',
                              union: 'kg',
                              value:
                                  '${state.trainingRecords.getOverAllWeight}',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TrainingCalendar(state.trainingRecords),
                ] else if (tabIndex.value == 1) ...[
                  TrainingReaderChart(state.trainingRecords),
                  const SizedBox(height: 16),
                  TrainingLineChart(state.trainingRecords),
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
  final String union;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.union,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF333333)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.orange, size: 24),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Expanded(
            child: FittedBox(
              alignment: Alignment.bottomLeft,
              fit: BoxFit.scaleDown,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    union,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
