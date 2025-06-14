import 'package:flutter/material.dart';

class RestTimer extends StatelessWidget {
  final int duration;
  final VoidCallback onFinish;

  const RestTimer({required this.duration, required this.onFinish, super.key});

  @override
  Widget build(BuildContext context) {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    final progress = 1 - duration / (duration == 0 ? 1 : duration);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '休憩中…',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 12,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation(Colors.deepOrangeAccent),
                ),
              ),
              Text(
                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: onFinish,
            child: const Text(
              '休憩をスキップ',
              style: TextStyle(color: Colors.deepOrangeAccent),
            ),
          ),
        ],
      ),
    );
  }
}
