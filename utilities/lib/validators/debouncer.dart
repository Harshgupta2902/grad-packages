import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final int delay;
  Timer? _timer;

  Debounce({required this.delay});

  void run(void Function() action) {

      debugPrint("debounce called");
    _timer?.cancel();

    _timer = Timer(Duration(milliseconds: delay), action);
  }
}
