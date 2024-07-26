import 'package:flutter/material.dart';

ButtonStyle getOutlinedButtonStyle({
  double borderRadius = 8.0,
  Color foregroundColor = Colors.black,
  Color backgroundColor = Colors.transparent,
  Color borderColor = Colors.black,
  double borderWidth = 1.0,
  double width = 400,
  double height = 50.0,
  Color buttonColor = Colors.black,
  bool showShadow = true,
}) {
  return OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius,
        ),
      ),
    ),
    foregroundColor: foregroundColor,
    backgroundColor: backgroundColor,
    side: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
    minimumSize: Size(
      width,
      height,
    ),
  );
}
