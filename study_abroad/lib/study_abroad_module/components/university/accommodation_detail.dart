import 'package:flutter/material.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/models/university_details_model.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class AccommodationDetail extends StatelessWidget {
  const AccommodationDetail({super.key, this.result});

  final Result? result;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 70),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: AppBoxDecoration.getBoxDecoration(
                    showShadow: false,
                    color: AppColors.whiteSmoke,
                    borderRadius: 16,
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      AccommodationCard(
                        title: "on-campus",
                        data: result?.accommodation?.onCampus ?? [],
                      ),
                      const SizedBox(height: 16),
                      AccommodationCard(
                        title: "off-campus",
                        data: result?.accommodation?.offCampus ?? [],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kBottomNavigationBarHeight + 30),
        ],
      ),
    );
  }
}

class AccommodationCard extends StatelessWidget {
  const AccommodationCard({super.key, required this.title, required this.data});
  final String title;
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 14),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Image.asset(StudyAbroadAssetPath.campus, height: 80),
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          ...List.generate(data.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: AppBoxDecoration.getBorderBoxDecoration(
                      borderRadius: 6,
                      borderColor: AppColors.brightGrey,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(2),
                    child:
                        const Icon(Icons.arrow_forward_rounded, color: AppColors.boulder, size: 12),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      data[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
