import 'package:flutter/services.dart';
import 'package:utilities/validators/my_regex.dart';

class NumberOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (MyRegex.numericRegexWithoutDecimal.hasMatch(newValue.text)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}

class NumberRangeInputFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumberRangeInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final sanitizedText = newValue.text.replaceAll(RegExp(r'\s+'), '');
    if (sanitizedText.length > 4) {
      return oldValue;
    }
    try {
      final value = double.tryParse(sanitizedText);
      if (value != null && value >= min && value <= max) {
        return newValue;
      }
    } catch (e) {
      return oldValue;
    }
    return oldValue;
  }
}

class RegExpTextInputFormatter extends TextInputFormatter {
  final String regexPattern;

  RegExpTextInputFormatter({required this.regexPattern});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final regex = RegExp(regexPattern);
    if (!regex.hasMatch(newValue.text)) {
      return oldValue; // Reject the change.
    }
    return newValue;
  }
}

class DecimalInputFormatter extends TextInputFormatter {
  final int decimalRange;
  DecimalInputFormatter({required this.decimalRange});
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    if (text == '') {
      return newValue;
    }
    if (text == '.') {
      text = '0.';
    }
    try {
      double.parse(text);
    } catch (e) {
      return oldValue;
    }
    if (text.contains('.') && text.substring(text.indexOf('.') + 1).length > decimalRange) {
      return oldValue;
    }
    return newValue.copyWith(text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}

class TextOnlyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredText = newValue.text.replaceAll(RegExp('[^a-zA-Z]'), '');
    return newValue.copyWith(
      text: filteredText,
      selection: newValue.selection,
    );
  }
}
