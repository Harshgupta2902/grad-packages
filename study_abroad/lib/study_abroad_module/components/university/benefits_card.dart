import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:utilities/common/model/common_model.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class BenefitsCard extends StatelessWidget {
  const BenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: AppBoxDecoration.getBoxDecoration(color: AppColors.white),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            children: [
              const SizedBox(height: 6),
              Container(
                decoration: AppBoxDecoration.getBoxDecoration(
                  color: AppColors.whiteSmoke,
                  borderRadius: 10,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    Image.asset(StudyAbroadAssetPath.benefits, height: 22),
                    const SizedBox(width: 6),
                    Text(
                      "Benefits from Gradding",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(3, (index) {
                final data = [
                  KeyValuePair(
                      key: "Scholarships ",
                      value: "Available",
                      path: StudyAbroadAssetPath.scholarship),
                  KeyValuePair(
                      key: "Get Offer ",
                      value: "from University in 7 to 15 Days",
                      path: StudyAbroadAssetPath.offer),
                  KeyValuePair(
                      key: "Education Loan ",
                      value: "Approval in 24 Hours",
                      path: StudyAbroadAssetPath.loan),
                ];
                return Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(data[index].path ?? "", height: 22),
                      const SizedBox(width: 8),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            text: data[index].key,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600, color: AppColors.portLangOrange),
                            children: [
                              TextSpan(
                                text: data[index].value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisExtent: 56,
            mainAxisSpacing: 12,
          ),
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final data = [
              KeyValuePair(
                  key: "FREE", value: "Counselling from Experts", path: StudyAbroadAssetPath.free),
              KeyValuePair(
                  key: "Test Prep", value: "Approval in 24 hours", path: StudyAbroadAssetPath.test),
              KeyValuePair(
                  key: "VISA", value: "Assistance for Australia", path: StudyAbroadAssetPath.visa),
              KeyValuePair(
                  key: "Accommodation",
                  value: "Assistance for Australia",
                  path: StudyAbroadAssetPath.accommodation),
            ];
            return Row(
              children: [
                SvgPicture.asset(data[index].path ?? ""),
                const SizedBox(width: 6),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data[index].key, style: Theme.of(context).textTheme.bodyMedium),
                      Text(data[index].value, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
