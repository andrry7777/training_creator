import 'package:flutter/material.dart';

class ThemedTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ThemedTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(text, style: TextStyle(fontSize: 36)),
        ),
      ],
    );
  }
}
