import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppBoxDecoration.getBoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: 10,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            Text(
              "Filters",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(
              StudyAbroadAssetPath.filter,
              height: 17,
              width: 16,
            )
          ],
        ),
      ),
    );
  }
}
