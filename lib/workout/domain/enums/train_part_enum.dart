enum TrainPart {
  chest,
  shoulder,
  legs,
  back,
  arms,
  other,
}

extension TrainPartExtension on TrainPart {
  String get getStringName {
    switch(this) {
      case TrainPart.chest:
        return '腕';
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
}