import 'package:flutter/material.dart';
import 'package:utilities/theme/app_colors.dart';

class TryAgain extends StatelessWidget {
  const TryAgain({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Something Went Wrong!",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Try Again!",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Icon(
                  Icons.replay,
                  size: 22,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
