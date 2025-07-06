import 'package:flutter/material.dart';

enum TrainPart { chest, shoulder, legs, back, arms, other }

extension TrainPartExtension on TrainPart {
  String get getStringName {
    switch (this) {
      case TrainPart.chest:
        return '胸';
      case TrainPart.shoulder:
        return '肩';
      case TrainPart.legs:
        return '脚';
      case TrainPart.back:
        return '背中';
      case TrainPart.arms:
        return '腕';
      default:
        return 'その他';
    }
  }

  int get getTrainPartInt {
    switch (this) {
      case TrainPart.chest:
        return 1;
      case TrainPart.shoulder:
        return 2;
      case TrainPart.legs:
        return 3;
      case TrainPart.back:
        return 4;
      case TrainPart.arms:
        return 5;
      default:
        return 6;
    }
  }

  /// 部位に対応するアイコンを返します。
  IconData get icon {
    switch (this) {
      case TrainPart.chest:
        return Icons.accessibility;
      case TrainPart.shoulder:
        return Icons.person;
      case TrainPart.legs:
        return Icons.directions_run;
      case TrainPart.back:
        return Icons.accessibility_new;
      case TrainPart.arms:
        return Icons.fitness_center;
      default:
        return Icons.sports_gymnastics;
    }
  }
}

TrainPart getTrainPartFromInt(int num) {
  switch (num) {
    case 1:
      return TrainPart.chest;
    case 2:
      return TrainPart.shoulder;
    case 3:
      return TrainPart.legs;
    case 4:
      return TrainPart.back;
    case 5:
      return TrainPart.arms;
    default:
      return TrainPart.other;
  }
}
