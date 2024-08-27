import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:utilities/components/cached_image_network_container.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';

void studyMaterialSheet(
  BuildContext context, {
  required FileTypes extensions,
  String? imageUrl,
  String? audioUrl,
  String? videoUrl,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: false,
    barrierColor: Colors.black87,
    shape: const SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.vertical(
        top: SmoothRadius(cornerRadius: 16, cornerSmoothing: 1.0),
      ),
    ),
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return StudyMaterialSheet(
        extensions: extensions,
        audioUrl: audioUrl,
        imageUrl: imageUrl,
        videoUrl: StudyAbroadAssetPath.video,
      );
    },
  );
}

class StudyMaterialSheet extends StatefulWidget {
  const StudyMaterialSheet({
    super.key,
    required this.extensions,
    this.imageUrl,
    this.audioUrl,
    this.videoUrl,
  });

  final FileTypes extensions;
  final String? imageUrl;
  final String? audioUrl;
  final String? videoUrl;

  @override
  StudyMaterialSheetState createState() => StudyMaterialSheetState();
}

class StudyMaterialSheetState extends State<StudyMaterialSheet> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 20,
          top: 40,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.cancel,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        if (widget.extensions == FileTypes.image && widget.imageUrl != null)
          Center(
            child: CachedImageNetworkContainer(
              color: Colors.transparent,
              height: null,
              width: null,
              url: widget.imageUrl,
              placeHolder: buildPlaceholder(
                name: "U",
                context: context,
              ),
            ),
          ),
      ],
    );
  }
}
