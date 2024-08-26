import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/models/application_manager_model.dart';
import 'package:study_abroad/study_abroad_module/models/university_details_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class UniversityDetailsController extends GetxController with StateMixin<UniversityDetailsModel> {
  getDetails({required String city, required String university}) async {
    const apiEndPoint = APIEndPoints.getUniversityDetails;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {'country': city, 'university_url': university},
      );

      debugPrint("UniversityDetailsController => getDetails > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = UniversityDetailsModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getDetails End With Error ----------");
      debugPrint("UniversityDetailsController => getDetails > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getDetails End ----------");
    }
  }
}
