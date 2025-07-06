import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerManager {
  static final TimerManager _instance = TimerManager._internal();

  factory TimerManager() => _instance;

  TimerManager._internal();

  Timer? _timer;
  int _timeLeft = 0;
  ValueChanged<int>? onTick;
  VoidCallback? onComplete;

  void start({
    required int seconds,
    required ValueChanged<int> onTick,
    required VoidCallback onComplete,
  }) {
    cancel();
    _timeLeft = seconds;
    this.onTick = onTick;
    this.onComplete = onComplete;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeLeft--;
      onTick(_timeLeft);

      if (_timeLeft <= 0) {
        timer.cancel();
        _timer = null;
        onComplete();
      }
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  bool get isRunning => _timer != null;
}
