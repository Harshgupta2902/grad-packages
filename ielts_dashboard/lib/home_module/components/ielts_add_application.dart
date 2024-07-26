import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_colors.dart';

class IeltsAddApplication extends StatelessWidget {
  const IeltsAddApplication({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
    required this.completionPercentage,
    required this.title,
    required this.desc,
  });

  final num totalTasks;
  final num completedTasks;
  final double completionPercentage;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(
            IeltsAssetPath.appManagerBackgroundBlue,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  desc,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(height: 14),
                Text(
                  "$completedTasks / $totalTasks",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  color: AppColors.yellowyGreen,
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 4,
                  ),
                  backgroundColor: Colors.grey,
                  minHeight: 8,
                  value: completionPercentage,
                )
              ],
            ),
          ),
          Flexible(
            child: SvgPicture.asset(
              IeltsAssetPath.ieltsGoal,
            ),
          ),
        ],
      ),
    );
  }
}
