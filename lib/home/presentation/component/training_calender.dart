import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus_for_hive.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';

class TrainingCalendar extends StatelessWidget {
  const TrainingCalendar(this.records, {super.key});

  final List<TrainingMenuForHive> records;

  @override
  Widget build(BuildContext context) {
    return _buildCalendarContainer(child: _buildCalendar());
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      calendarFormat: CalendarFormat.month,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        defaultTextStyle: const TextStyle(color: Colors.white),
        weekendTextStyle: TextStyle(color: Colors.grey[400]),
        outsideDaysVisible: false,
      ),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.orange),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.orange),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.grey[400]),
        weekendStyle: TextStyle(color: Colors.grey[500]),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final trainData = records.where(
            (d) =>
                d.createdAt.year == day.year &&
                d.createdAt.month == day.month &&
                d.createdAt.day == day.day,
          );

          if (trainData.isNotEmpty) {
            final trainPart = getTrainPartFromInt(trainData.first.trainPartInt);
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (_) => Dialog(
                        backgroundColor: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${day.month}/${day.day}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '総重量: ${trainData.fold<int>(0, (sum, e) => sum + (e.weight * e.reps))}kg',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: ListView(
                                  children:
                                      trainData
                                          .fold<
                                            Map<
                                              String,
                                              List<TrainingMenuForHive>
                                            >
                                          >({}, (map, e) {
                                            map
                                                .putIfAbsent(e.menu, () => [])
                                                .add(e);
                                            return map;
                                          })
                                          .entries
                                          .map(
                                            (entry) => Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 12,
                                              ),
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade900,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: Colors.grey.shade800,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    entry.key,
                                                    style: const TextStyle(
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  ...entry.value.map(
                                                    (set) => Text(
                                                      '${set.weight}kg x ${set.reps}回',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orange, width: 2),
                ),
                child: Center(child: Icon(trainPart.icon, color: Colors.white)),
              ),
            );
          }

          return null; // デフォルト描画にフォールバック
        },
      ),
    );
  }

  Widget _buildCalendarContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: Center(child: child),
    );
  }
}
