import 'package:flutter/material.dart';
import '../packages/smooth_rectangular_border.dart';
import 'app_colors.dart';

class AppBoxDecoration {
  static BoxDecoration getBoxDecoration({
    double borderRadius = 10,
    Color color = Colors.white,
    double spreadRadius = 0,
    double blurRadius = 20,
    bool showShadow = true,
    Color shadowColor = Colors.black,
    double shadowOpacity = 0.06,
    double offsetX = 0,
    double offsetY = 4,
  }) {
    return BoxDecoration(
      borderRadius: SmoothBorderRadius(
        cornerRadius: borderRadius,
        cornerSmoothing: 1.0,
      ),
      color: color,
      boxShadow: [
        if (showShadow)
          BoxShadow(
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            color: shadowColor.withOpacity(shadowOpacity),
            offset: Offset(offsetX, offsetY),
          ),
      ],
    );
  }

  static BoxDecoration getBorderBoxDecoration({
    double borderRadius = 16,
    Color color = Colors.white,
    double borderWidth = 1,
    Color borderColor = AppColors.frenchGrey,
    double spreadRadius = 0,
    double blurRadius = 12,
    bool showShadow = true,
    Color shadowColor = AppColors.black04,
    double offsetX = 0,
    double offsetY = 4,
  }) {
    return BoxDecoration(
      borderRadius: SmoothBorderRadius(
        cornerRadius: borderRadius,
        cornerSmoothing: 1.0,
      ),
      color: color,
      border: Border.all(
        width: borderWidth,
        color: borderColor,
      ),
      boxShadow: [
        if (showShadow)
          BoxShadow(
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            color: shadowColor,
            offset: Offset(offsetX, offsetY),
          ),
      ],
    );
  }
}
