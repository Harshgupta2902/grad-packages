import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/navigation/study_abroad_go_paths.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

typedef ShortListCallBack = void Function(bool);

class CoursesCard extends StatelessWidget {
  const CoursesCard({
    super.key,
    this.courseName,
    this.universityName,
    this.country,
    this.fees,
    this.duration,
    this.intakes,
    this.shortlist,
    this.shortListCallBack,
    this.applyNowOnTap,
    required this.typeCard,
    this.applied,
  });

  final String? courseName;
  final String? universityName;
  final String? country;
  final String? fees;
  final String? duration;
  final String? intakes;
  final bool? shortlist;
  final bool? applied;
  final ShortListCallBack? shortListCallBack;
  final void Function()? applyNowOnTap;
  final ApplicationStage typeCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 22),
      decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseName ?? "-",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(StudyAbroadAssetPath.university),
              const SizedBox(width: 6),
              Text(
                "University:",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  universityName ?? "-",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.boulder,
                        fontWeight: FontWeight.w400,
                      ),
                  maxLines: 2,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset(StudyAbroadAssetPath.country),
              const SizedBox(width: 6),
              Text(
                "Country:",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(width: 10),
              Text(
                country ?? "-",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.boulder,
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(StudyAbroadAssetPath.intakes),
              const SizedBox(width: 6),
              Text(
                "Intakes:",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: intakes?.split(", ").map((intake) {
                        return Container(
                          decoration: AppBoxDecoration.getBoxDecoration(
                            color: AppColors.asparagus.withOpacity(0.1),
                            borderRadius: 6,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          child: Text(
                            intake,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.fernGreen,
                                ),
                          ),
                        );
                      }).toList() ??
                      [],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset(StudyAbroadAssetPath.fees),
              const SizedBox(width: 6),
              Text(
                "Yearly Tuition Fees:",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(width: 10),
              Text(
                fees ?? "-",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.boulder,
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset(StudyAbroadAssetPath.duration),
              const SizedBox(width: 6),
              Text(
                "Duration:",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(width: 10),
              Text(
                duration ?? "-",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.boulder,
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
          const SizedBox(height: 6),
          if (applied == true) ...[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 10,
                    cornerSmoothing: 1.0,
                  ),
                ),
                side: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () {
                context.pushNamed(
                  StudyAbroadGoPaths.applicationManager,
                  extra: {'tabIndex': 1},
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "View Application",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: AppColors.primaryColor,
                    size: 16,
                  )
                ],
              ),
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(
                          cornerRadius: 10,
                          cornerSmoothing: 1.0,
                        ),
                      ),
                      side: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width, 40),
                    ),
                    onPressed: applyNowOnTap,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          typeCard == ApplicationStage.shortlisted ? "Apply Now" : "Consult Now",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: AppColors.primaryColor,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),
                if (typeCard != ApplicationStage.shortlisted)
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Shortlist",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            activeColor: AppColors.primaryColor,
                            inactiveTrackColor: AppColors.blueHaze.withOpacity(0.2),
                            trackOutlineColor: const MaterialStatePropertyAll(AppColors.blueHaze),
                            value: shortlist ?? false,
                            onChanged: (value) {
                              shortListCallBack!(value);
                            },
                            thumbColor: const MaterialStatePropertyAll(AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}
