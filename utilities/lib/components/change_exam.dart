import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guest_dashboard/constants/guest_asset_paths.dart';
import 'package:guest_dashboard/test_module/controller/update_exam_name.dart';
import 'package:utilities/packages/dialogs.dart';

final _updateExamNameController = Get.put(UpdateExamNameController());

class ChangeExam {
  static Future<void> changeExams({
    required BuildContext context,
  }) async {
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        Dialogs.selectTestPrepDialog(
          context,
          data: [
            GuestAssetPath.ielts,
            GuestAssetPath.pte,
            GuestAssetPath.toefl,
            GuestAssetPath.duolingo
          ],
          examCallBack: (selectedExam) {
            final examNameExt = selectedExam?.split('/').last;
            final examName = examNameExt?.split('.').first;
            final selectedExamName = examName?.toUpperCase();

            if (selectedExamName != null) {
              var data = [];
              if (selectedExamName == "PTE") {
                data = ["Core", "Academic"];
              } else if (selectedExamName == "DUOLINGO") {
                data = ["Academic"];
              } else {
                data = ["General", "Academic"];
              }
              // Navigator.of(context).pop();
              Future.delayed(const Duration(milliseconds: 100), () {
                Dialogs.selectTestCatDialog(
                  context,
                  data: data,
                  examCatCallBack: (selectedExamCategory) {
                    final selectedExamCat = selectedExamCategory;
                    debugPrint(
                        "selectedExam:::::$selectedExamName ___________ examCat:::::::::::$selectedExamCat");
                    _updateExamNameController.updateExamName(
                      testType: selectedExamName,
                      subTestType: selectedExamCat,
                    );
                    //     .then((value) {
                    //   Navigator.of(context).pop();
                    // });
                  },
                );
              });
            }
          },
        );
      },
    );
  }
}
