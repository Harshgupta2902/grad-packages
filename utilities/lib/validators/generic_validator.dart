import 'my_regex.dart';

class GenericValidator {
  static String? required({
    required String? value,
    String? message,
  }) {
    if (value == null || value.isEmpty == true) {
      return message ?? "Required";
    }
    return null;
  }

  static String? regexMatch({
    required String? value,
    required RegExp regex,
    String? message,
  }) {
    if (value == null || value.isEmpty == true) {
      return message ?? "Required";
    }

    if (regex.hasMatch(value) == false) {
      return message ?? "Not Match";
    }
    return null;
  }

  static String? nameValidator({
    required String value,
    String? message,
  }) {
    if (value.length < 3) {
      return 'Enter your full name';
    }
    return null;
  }

  static String? minimum({
    required String? value,
    required num? min,
    String? message,
  }) {
    if (value == null || value.isEmpty == true) {
      return "Enter a valid amount";
    }

    final number = num.tryParse(value);

    if (number == null) {
      return "Enter a valid amount";
    }

    if (min == null) {
      return 'Min amount not available';
    }
    if (number < min) {
      return "min allowed is $min";
    }

    return null;
  }

  static String? numberValidator({
    required String? value,
    String? message,
  }) {
    if (value == null || value.isEmpty || MyRegex.numericRegex.hasMatch(value) == false) {
      return message ?? 'Enter a valid number';
    }

    return null;
  }

  static String? durationValidator({required String? value}) {
    if (value == null || value.isEmpty) {
      return 'Enter Duration';
    }

    if (num.parse(value) > 60) {
      return 'Max: 60Y';
    }

    return null;
  }

  static String? checkLength({
    required String? value,
    required int length,
    String? message,
  }) {
    if (value == null || value.isEmpty == true) {
      return null;
    }
    if (value.length < length) {
      return message ?? "Invalid Length";
    }
    return null;
  }
}
