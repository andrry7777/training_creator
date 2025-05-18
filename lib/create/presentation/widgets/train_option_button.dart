import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:train_menu_creator/app/router/route_names.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';

class SelectTrainPartButton extends StatelessWidget {
  final String text;
  final TrainPart trainPart;

  const SelectTrainPartButton({
    super.key,
    required this.text,
    required this.trainPart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => context.go(RouteNames.createMenu, extra: trainPart),
          child: Text(text, style: TextStyle(fontSize: 36)),
        ),
      ],
    );
  }
}
