import 'package:hive/hive.dart';

class TrainingMenuForHive {
  final int trainPartInt;
  final String menu;
  final int rest;
  final int weight;
  final int reps;
  final String id;
  final DateTime createdAt;

  TrainingMenuForHive({
    required this.trainPartInt,
    required this.menu,
    required this.rest,
    required this.weight,
    required this.reps,
    required this.id,
    required this.createdAt,
  });
}

class TrainingMenuForHiveAdapter extends TypeAdapter<TrainingMenuForHive> {
  @override
  final int typeId = 0;

  @override
  TrainingMenuForHive read(BinaryReader reader) {
    return TrainingMenuForHive(
      trainPartInt: reader.readInt(),
      menu: reader.readString(),
      rest: reader.readInt(),
      weight: reader.readInt(),
      reps: reader.readInt(),
      id: reader.readString(),
      createdAt: DateTime.parse(reader.readString()),
    );
  }

  @override
  void write(BinaryWriter writer, TrainingMenuForHive obj) {
    writer.writeInt(obj.trainPartInt);
    writer.writeString(obj.menu);
    writer.writeInt(obj.rest);
    writer.writeInt(obj.weight);
    writer.writeInt(obj.reps);
    writer.writeString(obj.id);
    writer.writeString(obj.createdAt.toIso8601String());
  }
}
