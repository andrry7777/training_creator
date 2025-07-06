import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus_for_hive.dart';
import 'package:train_menu_creator/workout/application/extentions/training_menus_list_ext.dart';

class TrainingLineChart extends StatelessWidget {
  const TrainingLineChart(this.records, {super.key});

  final List<TrainingMenuForHive> records;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final data = List.generate(6, (i) {
      final targetMonth = DateTime(now.year, now.month - (5 - i));
      final totalWeight = records.getTotalWeightTargetMonth(targetMonth);
      return {
        'label': '${targetMonth.month}月',
        'value': totalWeight.toDouble(),
      };
    });

    final maxY =
        data.map((e) => e['value'] as double).reduce((a, b) => a > b ? a : b) *
        1.2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '月ごとの総重量推移',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 300,
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF333333)),
          ),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY,
              barTouchData: BarTouchData(enabled: false),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withValues(alpha: 0.2),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: maxY / 4,
                    getTitlesWidget: (value, meta) {
                      return SizedBox(
                        width: 40,
                        child: Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                      );
                    },
                    reservedSize: 32,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < data.length) {
                        return Text(
                          data[index]['label'].toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    reservedSize: 30,
                  ),
                ),
              ),
              barGroups:
                  data.asMap().entries.map((entry) {
                    final index = entry.key;
                    final value = entry.value['value'] as double;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value,
                          width: 18,
                          gradient: const LinearGradient(
                            colors: [Colors.deepOrange, Colors.amber],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: maxY,
                            color: const Color(0xFF2A2A2A),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
