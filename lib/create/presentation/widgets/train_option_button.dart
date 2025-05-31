import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectMenuButton extends StatelessWidget {
  final String text;
  final String routeName;

  const SelectMenuButton({
    super.key,
    required this.text,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => context.go(routeName),
          child: Text(text, style: TextStyle(fontSize: 36)),
        ),
      ],
    );
  }
}
