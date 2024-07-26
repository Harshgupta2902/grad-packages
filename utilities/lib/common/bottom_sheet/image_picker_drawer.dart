import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_colors.dart';

typedef ImagePickerCallback = void Function();

documentPickerOptionsDrawer({
  required BuildContext context,
  String? docType,
  String? bankId,
  Rx<Doc>? rxDoc,
  int? index,
  required ImagePickerCallback onTapCamera,
  required ImagePickerCallback onTapGallery,
}) {
  return showModalBottomSheet(
    context: context,
    shape: const SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.vertical(
        top: SmoothRadius(cornerRadius: 12, cornerSmoothing: 1.0),
        bottom: SmoothRadius.zero,
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // FILE PICKER IMAGE FROM CAMERA
              Expanded(
                child: GestureDetector(
                  onTap: onTapCamera,
                  child: ColorContainer(
                    bgColor: AppColors.backgroundColor,
                    borderRadius: 16,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.camera_alt_rounded,
                          size: 40,
                          color: AppColors.black,
                        ),
                        Text(
                          'Camera',
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // FILE PICKER IMAGE FROM GALLERY
              Expanded(
                child: GestureDetector(
                  onTap: onTapGallery,
                  child: ColorContainer(
                    bgColor: AppColors.backgroundColor,
                    borderRadius: 16,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.photo_library_rounded,
                          size: 40,
                          color: AppColors.black,
                        ),
                        Text(
                          'Gallery',
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class Doc {
  Doc({
    this.documentType,
    this.url,
    this.icon,
  });

  Doc.fromJson(dynamic json) {
    documentType = json['document_type'];
    url = json['url'];
    icon = json['icon'];
  }

  String? documentType;
  String? url;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['document_type'] = documentType;
    map['url'] = url;
    map['icon'] = icon;
    return map;
  }
}

class ColorContainer extends StatelessWidget {
  final Color bgColor;
  final double borderRadius;
  final double? width;
  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;

  const ColorContainer({
    Key? key,
    required this.bgColor,
    required this.borderRadius,
    required this.child,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
