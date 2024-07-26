import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:utilities/theme/app_colors.dart';

class CustomErrorOrEmpty extends StatelessWidget {
  final double? height;
  final double? width;
  final String? title;

  const CustomErrorOrEmpty({
    super.key,
    this.height,
    this.width,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          "packages/utilities/assets/empty.json",
          height: 100,
          width: 100,
        ),
        Text(
          title ?? "No data Found",
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
