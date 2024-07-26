import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/controller/delete_document_controller.dart';
import 'package:study_abroad/study_abroad_module/controller/get_documents_list.dart';
import 'package:utilities/components/button_loader.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_colors.dart';

final _deleteDocumentController = Get.put(DeleteDocumentController());
final _getDocumentsController = Get.put(GetDocumentsListController());

void deleteDocumentSheet(BuildContext context, {required String docType, required String docId}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.vertical(
        top: SmoothRadius(cornerRadius: 16, cornerSmoothing: 1.0),
      ),
    ),
    builder: (BuildContext context) {
      return DeleteDocumentSheet(
        docType: docType,
        docId: docId,
      );
    },
  );
}

class DeleteDocumentSheet extends StatefulWidget {
  final String docType;
  final String docId;

  const DeleteDocumentSheet({
    Key? key,
    required this.docType,
    required this.docId,
  }) : super(key: key);

  @override
  DeleteDocumentSheetState createState() => DeleteDocumentSheetState();
}

class DeleteDocumentSheetState extends State<DeleteDocumentSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            StudyAbroadAssetPath.delete,
            height: 40,
          ),
          Text(
            "Are you sure you want to Delete \"${widget.docType}\" ",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            "All of your data will be permanently removed.This action can not be undone.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cadmiumRed,
            ),
            onPressed: () async {
              await _deleteDocumentController.deleteDocument(docId: widget.docId).then((value) {
                if (value['status'].toString() == "1") {
                  _getDocumentsController.getDocuments();
                }
              });

              Future.delayed(
                Duration.zero,
                () => context.pop(),
              );
            },
            child: ButtonLoader(
              isLoading: _deleteDocumentController.isLoading,
              buttonString: "Delete",
              loaderString: "",
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
