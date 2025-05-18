import 'package:flutter/material.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';
import 'package:train_menu_creator/create/presentation/widgets/train_option_button.dart';

class SelectPartScreen extends StatelessWidget {
  const SelectPartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('目指せムキムキ'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectTrainPartButton(text: '胸', trainPart: TrainPart.chest),
            SelectTrainPartButton(text: '肩', trainPart: TrainPart.shoulder),
            SelectTrainPartButton(text: '足', trainPart: TrainPart.legs),
            SelectTrainPartButton(text: '背中', trainPart: TrainPart.back),
            SelectTrainPartButton(text: '腕', trainPart: TrainPart.arms),
          ],
        ),
      ),
    );
  }
}
