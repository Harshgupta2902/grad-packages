import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/models/university_unifinder_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class UniversityUnifinderController extends GetxController
    with StateMixin<UniversityUnifinderModel> {
  RxBool isLoading = RxBool(false);
  int loadMoreCount = 1;

  getUniversityApi({
    String? offset,
    String? currency,
    Map<String, dynamic>? filterPostData,
  }) async {
    const apiEndPoint = APIEndPoints.getUniversity;
    isLoading.value = true;
    debugPrint("---------- $apiEndPoint getUniversityApi Start ----------");
    try {
      final Map<String, dynamic> postData = {
        "currency": currency ?? "INR",
        "limit": "10",
        "offset": offset,
        "search": "",
      };

      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: filterPostData ?? postData,
      );

      debugPrint("UniversityUnifinderController =>  getUniversityApi > Success $response ");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      if (offset == '1') {
        final modal = UniversityUnifinderModel.fromJson(response.data);
        change(modal, status: RxStatus.success());
      } else {
        final modal = UniversityUnifinderModel.fromJson(response.data);
        state?.result?.university?.addAll(modal.result?.university ?? []);
        change(state, status: RxStatus.success());
      }
    } catch (error) {
      debugPrint("---------- $apiEndPoint  getUniversityApi End With Error ----------");
      debugPrint(" UniversityUnifinderController =>  getUniversityApi > Error $error ");
      change(null, status: RxStatus.error(error.toString()));
    } finally {
      isLoading.value = false;
      debugPrint("---------- $apiEndPoint  getUniversityApi End ----------");
    }
  }
}
