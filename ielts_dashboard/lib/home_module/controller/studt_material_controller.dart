import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ielts_dashboard/home_module/model/study_material_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class StudyMaterialController extends GetxController with StateMixin<StudyMaterialModel> {
  getStudyMaterial() async {
    const apiEndPoint = APIEndPoints.studyMaterial;
    debugPrint("---------- $apiEndPoint getStudyMaterial Start ----------");

    try {
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("StudyMaterialController => getStudyMaterial > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = StudyMaterialModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getStudyMaterial End With Error ----------");
      debugPrint("StudyMaterialController => getStudyMaterial > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getStudyMaterial End ----------");
    }
  }
}
