import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_filex/open_filex.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/components/documents/upload_button.dart';
import 'package:utilities/common/bottom_sheet/delete_document_sheet.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class DocumentsCard extends StatelessWidget {
  const DocumentsCard({
    super.key,
    required this.doc,
    required this.status,
    this.single = false,
    this.docId,
    this.downloadLink,
  });

  final String? doc;
  final String? status;
  final String? docId;
  final String? downloadLink;
  final bool? single;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppBoxDecoration.getBoxDecoration(
        color: single == true ? Colors.white : AppColors.whiteSmoke,
        showShadow: single ?? false,
        borderRadius: 8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                if (status == "uploaded") ...[
                  SvgPicture.asset(
                    StudyAbroadAssetPath.uploaded,
                    height: 20,
                  ),
                  const SizedBox(width: 6),
                ],
                Flexible(
                  child: Text(
                    "$doc",
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              if (status == "uploaded") ...[
                PopupMenuButton(
                  splashRadius: 0,
                  surfaceTintColor: Colors.transparent,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(cornerRadius: 10),
                    side: const BorderSide(width: 0.50, color: Color(0x3F747579)),
                  ),
                  color: AppColors.white,
                  onSelected: (value) {
                    if (value == 1) {
                      debugPrint("download");
                      FileDownloader.downloadFile(
                        url: downloadLink.toString(),
                        downloadDestination: DownloadDestinations.publicDownloads,
                        onDownloadCompleted: (path) async {
                          debugPrint("path:::::::::::::::$path");
                          String decodedUrl = Uri.decodeFull(path);
                          await OpenFilex.open(decodedUrl);
                        },
                      );
                    }

                    if (value == 3) {
                      debugPrint("delete sheeet");
                      deleteDocumentSheet(
                        context,
                        docType: doc ?? "",
                        docId: docId.toString(),
                      );
                      return;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      height: MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height - 29),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                StudyAbroadAssetPath.view,
                                height: 20,
                              ),
                              const SizedBox(width: 10),
                              Text('Download', style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      enabled: false,
                      padding: const EdgeInsets.all(0),
                      height: 0.1,
                      value: 2,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                        height: 1,
                        width: double.infinity,
                        color: AppColors.subtitle,
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      height: MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height - 29),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                StudyAbroadAssetPath.delete,
                                height: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Delete',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Transform.rotate(
                      angle: 90 * (3.1415926535897932 / 180),
                      child: SvgPicture.asset(
                        StudyAbroadAssetPath.dotmenu,
                      ),
                    ),
                  ),
                )
              ],
              if (status != "uploaded") ...[
                GestureDetector(
                  onTap: () async {
                    await pickFile(context: context, docName: "$doc");
                  },
                  child: SvgPicture.asset(
                    StudyAbroadAssetPath.upload,
                    height: 20,
                  ),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }
}
