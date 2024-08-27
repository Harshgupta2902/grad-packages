import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/models/university_details_model.dart';
import 'package:utilities/common/bottom_sheet/study_material_sheet.dart';
import 'package:utilities/components/cached_image_network_container.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class GalleryDetail extends StatelessWidget {
  const GalleryDetail({super.key, this.result});

  final Result? result;

  @override
  Widget build(BuildContext context) {
    final mediaList = [...result?.images ?? [], ...result?.videos ?? []];

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
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: mediaList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          mainAxisExtent: 80,
                          crossAxisSpacing: 12),
                      itemBuilder: (context, index) {
                        final mediaUrl = mediaList[index];
                        final isVideo = mediaUrl.contains('youtube.com');
                        return GestureDetector(
                          onTap: () {
                            if (isVideo) {
                              debugPrint("video:::::::$mediaUrl");
                              final uri = Uri.parse(mediaUrl);
                              final videoId = uri.pathSegments.last;
                              final url = "https://www.youtube.com/watch?v=$videoId";
                              debugPrint("final video url:::::::$url");

                              context.pushNamed(
                                GuestGoPaths.youtubeVideoView,
                                extra: {'url': url},
                              );
                            } else {
                              debugPrint("image:::::::$mediaUrl");
                              studyMaterialSheet(context,
                                  extensions: FileTypes.image, imageUrl: mediaUrl);
                            }
                          },
                          child: isVideo
                              ? Stack(
                                  children: [
                                    CachedImageNetworkContainer(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: AppColors.white, width: 2),
                                      ),
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      height: 80,
                                      url: getYoutubeThumbnailUrl(mediaUrl),
                                      placeHolder: buildPlaceholder(name: "", context: context),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: SvgPicture.asset(StudyAbroadAssetPath.play),
                                      ),
                                    ),
                                  ],
                                )
                              : CachedImageNetworkContainer(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: AppColors.white, width: 2),
                                  ),
                                  url: mediaUrl,
                                  placeHolder: buildPlaceholder(name: "", context: context),
                                ),
                        );
                      },
                    )),
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
