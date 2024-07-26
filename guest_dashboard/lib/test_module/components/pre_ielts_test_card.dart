import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/constants/guest_asset_paths.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class PreIeltsTestCard extends StatelessWidget {
  const PreIeltsTestCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        image: const DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(
            IeltsAssetPath.appManagerBackgroundBlue,
          ),
        ),
        borderRadius: SmoothBorderRadius(
          cornerRadius: 16,
          cornerSmoothing: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Predict your IELTS Band",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  "98% students got exact IELTS Band",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.marineBlue,
                  ),
                  onPressed: () {
                    context.pushNamed(GuestGoPaths.guestPreTestScreen);
                  },
                  child: const Text("Start FREE Pre-IELTS Test"),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              decoration: AppBoxDecoration.getBoxDecoration(
                color: Colors.transparent,
                shadowColor: Colors.white,
                blurRadius: 12,
                spreadRadius: 0,
              ),
              child: Image.asset(
                GuestAssetPath.testBanner,
                fit: BoxFit.fitHeight,
                height: 140,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
