import 'package:flutter/material.dart';


extension ColorExtension on num? {
  Color getColorFromRange() {
    if (this! >= 0 && this! <= 3) {
      return Colors.red;
    } else if (this! > 3 && this! <= 5) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }
}

extension EmojiExtension on num? {
  String getEmojiFromRange() {
    if (this! >= 0 && this! <= 2) {
      return '☹️';
    } else if (this! > 2 && this! <= 4) {
      return '😐'; // Neutral face emoji for medium range
    } else if (this! > 4 && this! <= 7) {
      return '🙂'; // Slightly smiling face emoji for happy range
    } else {
      return '😃'; // Big smiling face emoji for very happy range
    }
  }
}

