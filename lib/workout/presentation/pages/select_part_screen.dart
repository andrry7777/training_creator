import 'package:flutter/material.dart';
import 'package:train_menu_creator/workout/presentation/widgets/train_option_button.dart';

class SelectPartScreen extends StatelessWidget {
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
            ThemedTextButton(text: '胸', onPressed: () {}),
            ThemedTextButton(text: '肩', onPressed: () {}),
            ThemedTextButton(text: '足', onPressed: () {}),
            ThemedTextButton(text: '背中', onPressed: () {}),
            ThemedTextButton(text: '腕', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
