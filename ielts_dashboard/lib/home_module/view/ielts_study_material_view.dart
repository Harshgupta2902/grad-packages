import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_dashboard/home_module/controller/studt_material_controller.dart';
import 'package:ielts_dashboard/navigation/ielts_go_paths.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:utilities/common/bottom_sheet/study_material_sheet.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/components/try_again.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _studyMaterialController = Get.put(StudyMaterialController());

class IeltsStudyMaterialView extends StatefulWidget {
  const IeltsStudyMaterialView({
    Key? key,
  }) : super(key: key);

  @override
  State<IeltsStudyMaterialView> createState() => IeltsStudyMaterialViewState();
}

class IeltsStudyMaterialViewState extends State<IeltsStudyMaterialView> {
  @override
  void initState() {
    super.initState();
    _studyMaterialController.getStudyMaterial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: _studyMaterialController.obx(
        (state) {
          return state?.studyMaterials?.isEmpty == true || state?.studyMaterials == []
              ? const Center(
                  child: CustomErrorOrEmpty(
                    title: "No Study Material available right now",
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 130,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state?.studyMaterials?.length ?? 0,
                  itemBuilder: (context, index) {
                    final data = state?.studyMaterials?[index];
                    final url = data?.filePath;
                    final title = "Day (${data?.day}) ${data?.fileName}";
                    return GestureDetector(
                      onTap: () {
                        onTapFunction(context, url ?? "");
                        // studyMaterialSheet(context, extensions: Extensions.image, imageUrl: url)
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: AppBoxDecoration.getBoxDecoration(
                          showShadow: true,
                          shadowColor: AppColors.primaryColor.withOpacity(0.06),
                          color: AppColors.white,
                          borderRadius: 6,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              getAssetPath("$url"),
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              title,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.brightGrey,
                                  ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
        onError: (error) => TryAgain(
          onTap: () => _studyMaterialController.getStudyMaterial(),
        ),
      ),
    );
  }
}

String getAssetPath(String url) {
  String extension = url.split('.').last.split('?').first.toLowerCase();
  switch (extension.toLowerCase()) {
    case 'png':
    case 'jpg':
    case 'jpeg':
    case 'gif':
    case 'bmp':
    case 'svg':
      return StudyAbroadAssetPath.image;
    case 'pdf':
      return StudyAbroadAssetPath.pdf;
    case 'ppt':
    case 'pptx':
      return StudyAbroadAssetPath.ppt;
    case 'mp3':
    case 'wav':
    case 'ogg':
    case 'm4a':
    case 'flac':
    case 'aac':
      return StudyAbroadAssetPath.sound;
    case 'mp4':
    case 'mov':
    case 'avi':
    case 'wmv':
    case 'mkv':
    case 'flv':
    case 'webm':
      return StudyAbroadAssetPath.video;
    case 'doc':
    case 'docx':
      return StudyAbroadAssetPath.word;
    default:
      return StudyAbroadAssetPath.generic;
  }
}

void onTapFunction(BuildContext context, String url) {
  final extension = getUrlExtension(url);

  switch (extension) {
    case 'png':
    case 'jpg':
    case 'jpeg':
    case 'gif':
    case 'bmp':
    case 'svg':
      studyMaterialSheet(context, extensions: FileTypes.image, imageUrl: url);
      break;
    case 'pdf':
      context.pushNamed(
        IeltsGoPaths.ieltsStudyMaterialWebView,
        extra: {"url": "https://docs.google.com/gview?url=$url"},
      );
      break;
    case 'ppt':
    case 'pptx':
      context.pushNamed(
        IeltsGoPaths.ieltsStudyMaterialWebView,
        extra: {"url": "https://view.officeapps.live.com/op/embed.aspx?src=$url"},
      );
      break;
    case 'mp3':
    case 'wav':
    case 'ogg':
    case 'm4a':
    case 'flac':
    case 'aac':
      studyMaterialSheet(context, extensions: FileTypes.sound, imageUrl: url);
      break;
    case 'mp4':
    case 'mov':
    case 'avi':
    case 'wmv':
    case 'mkv':
    case 'flv':
    case 'webm':
      studyMaterialSheet(context, extensions: FileTypes.video, imageUrl: url);
      break;
    case 'doc':
    case 'docx':
      context.pushNamed(
        IeltsGoPaths.ieltsStudyMaterialWebView,
        extra: {"url": "https://view.officeapps.live.com/op/embed.aspx?src=$url"},
      );
      break;
    default:
      studyMaterialSheet(context, extensions: FileTypes.image, imageUrl: url);
      break;
  }
}

String getUrlExtension(String url) {
  return url.split('.').last;
}
