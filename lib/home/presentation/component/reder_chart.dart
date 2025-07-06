import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus_for_hive.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/workout/application/extentions/training_menus_list_ext.dart';

class TrainingReaderChart extends StatelessWidget {
  const TrainingReaderChart(this.records, {super.key});

  final List<TrainingMenuForHive> records;

  @override
  Widget build(BuildContext context) {
    final labels = TrainPart.values;

    final allTimeFrequencies =
        labels.map((part) => records.getFrequencies(part)).toList();

    final recordThisMonth = records.getThirtyDaysRecord(DateTime.now());
    final latestFrequencies =
        labels.map((part) => recordThisMonth.getFrequencies(part)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            'トレーニング頻度（部位別）',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF333333)),
          ),
          child: RadarChart(
            RadarChartData(
              radarBackgroundColor: Colors.transparent,
              borderData: FlBorderData(show: false),
              radarShape: RadarShape.polygon,
              titleTextStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              getTitle:
                  (index, _) =>
                      RadarChartTitle(text: labels[index].getStringName),
              dataSets: [
                RadarDataSet(
                  dataEntries:
                      allTimeFrequencies
                          .map((e) => RadarEntry(value: e.toDouble()))
                          .toList(),
                  borderColor: Colors.orange,
                  fillColor: Colors.orange.withOpacity(0.3),
                  entryRadius: 3,
                  borderWidth: 2,
                ),
                RadarDataSet(
                  dataEntries:
                      latestFrequencies
                          .map((e) => RadarEntry(value: e.toDouble()))
                          .toList(),
                  borderColor: Colors.blue,
                  fillColor: Colors.blue.withOpacity(0.3),
                  entryRadius: 3,
                  borderWidth: 2,
                ),
              ],
              radarBorderData: const BorderSide(color: Color(0xFF333333)),
              tickBorderData: const BorderSide(
                color: Color(0xFF444444),
                width: 1,
              ),
              gridBorderData: const BorderSide(
                color: Color(0xFF444444),
                width: 1,
              ),
              tickCount: 4,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _LegendItem(color: Colors.orange, label: '全期間'),
              SizedBox(width: 16),
              _LegendItem(color: Colors.blue, label: '直近1ヶ月'),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
