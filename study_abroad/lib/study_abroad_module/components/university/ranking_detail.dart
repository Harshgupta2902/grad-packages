import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/components/university/read_more.dart';
import 'package:study_abroad/study_abroad_module/models/university_details_model.dart';
import 'package:utilities/common/bottom_sheet/study_material_sheet.dart';
import 'package:utilities/components/cached_image_network_container.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class RankingDetail extends StatelessWidget {
  const RankingDetail({super.key, this.result});

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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ReadMoreText(subtitle: result?.ranking?.overview),
                const SizedBox(height: 16),
                Container(
                  decoration: AppBoxDecoration.getBoxDecoration(),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Container(
                          decoration: AppBoxDecoration.getBoxDecoration(
                            color: AppColors.whiteSmoke,
                            borderRadius: 12,
                            showShadow: false,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "RANKED BY",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                  width: 70,
                                  child: Text(
                                    "2019",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                  width: 70,
                                  child: Text(
                                    "2020",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                  width: 70,
                                  child: Text(
                                    "2021",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                  width: 70,
                                  child: Text(
                                    "2022",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                  width: 70,
                                  child: Text(
                                    "2023",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                  width: 70,
                                  child: Text(
                                    "2024",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(result?.ranking?.ranks?.length ?? 0, (index) {
                          final ranks = result?.ranking?.ranks?[index];
                          return Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ranks?.publisher ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      ranks?.publishername ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(fontSize: 10, color: AppColors.boulder),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 70, child: Text(ranks?.rankings?.y19 ?? "")),
                              SizedBox(width: 70, child: Text(ranks?.rankings?.y20 ?? "")),
                              SizedBox(width: 70, child: Text(ranks?.rankings?.y21 ?? "")),
                              SizedBox(width: 70, child: Text(ranks?.rankings?.y22 ?? "")),
                              SizedBox(width: 70, child: Text(ranks?.rankings?.y23 ?? "")),
                              SizedBox(width: 70, child: Text(ranks?.rankings?.y24 ?? "")),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: kBottomNavigationBarHeight + 30),
        ],
      ),
    );
  }
}

String getYoutubeThumbnailUrl(String videoUrl) {
  final uri = Uri.parse(videoUrl);
  final videoId = uri.pathSegments.last; // Extract video ID from URL
  return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg'; // Generate thumbnail URL
}
