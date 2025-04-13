import 'package:flutter/material.dart';
import 'package:train_menu_creator/workout/presentation/widgets/train_option_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '目指せムキムキ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const MyHomePage(title: '目指せムキムキ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
