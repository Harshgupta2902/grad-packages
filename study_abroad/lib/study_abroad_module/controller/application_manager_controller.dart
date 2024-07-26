import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/models/application_manager_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class ApplicationManagerController extends GetxController with StateMixin<ApplicationManagerModel> {
  RxBool isLoading = RxBool(false);
  getApplications() async {
    const apiEndPoint = APIEndPoints.applicationManager;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {},
      );

      debugPrint("ApplicationManagerController => getApplications > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = ApplicationManagerModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getApplications End With Error ----------");
      debugPrint("ApplicationManagerController => getApplications > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getApplications End ----------");
    }
  }
}
