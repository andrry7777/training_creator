import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final todayMenuQuestionControllerProvider = ChangeNotifierProvider(
  (ref) => TodayMenuQuestionController(),
);

class TodayMenuQuestionController extends ChangeNotifier {
  String? equipment;
  int? duration;
  String? fatigue;
  String? level;

  void setEquipment(String? val) {
    equipment = val;
    notifyListeners();
  }

  void setDuration(int? val) {
    duration = val;
    notifyListeners();
  }

  void setFatigue(String? val) {
    fatigue = val;
    notifyListeners();
  }

  void setLevel(String? val) {
    level = val;
    notifyListeners();
  }

  bool get isValid =>
      equipment != null && duration != null && fatigue != null && level != null;

  void generateMenu(String selectedBodyPart) {
    // 本当はここでメニューを生成して、別画面に渡す or DB保存など
    print('--- メニュー生成 ---');
    print('部位: $selectedBodyPart');
    print('器具: $equipment');
    print('時間: $duration 分');
    print('体調: $fatigue');
    print('レベル: $level');
  }
}
