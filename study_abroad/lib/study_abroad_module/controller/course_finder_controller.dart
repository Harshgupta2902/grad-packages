import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/models/courses_unifinder_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class CoursesUnifinderController extends GetxController with StateMixin<CoursesUnifinderModel> {
  RxBool isLoading = RxBool(false);
  int loadMoreCount = 1;

  getCoursesApi({String? offset, Map<String, dynamic>? filterPostData}) async {
    isLoading.value = true;

    const apiEndPoint = APIEndPoints.getCourses;
    debugPrint("---------- $apiEndPoint getCoursesApi Start ----------");
    if (offset == '1') {
      change(null, status: RxStatus.loading());
    }
    try {
      final Map<String, dynamic> postData = {
        "currency": "local",
        "limit": "10",
        "offset": offset,
        "search": "",
      };

      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: filterPostData ?? postData,
      );

      debugPrint("CoursesUnifinderController =>  getCoursesApi > Success ${response.data} ");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      if (offset == '1') {
        debugPrint("Offset:::::::::::$offset::::::::::::;;insertion");
        final modal = CoursesUnifinderModel.fromJson(response.data);
        change(modal, status: RxStatus.success());
      } else {
        debugPrint("Offset::::::::::$offset:::::::::::::;;adding");
        final modal = CoursesUnifinderModel.fromJson(response.data);
        state?.result?.courses?.addAll(modal.result?.courses ?? []);
        change(state, status: RxStatus.success());
      }
    } catch (error) {
      debugPrint("---------- $apiEndPoint  getCoursesApi End With Error ----------");
      debugPrint(" CoursesUnifinderController =>  getCoursesApi > Error $error ");
      change(null, status: RxStatus.error(error.toString()));
    } finally {
      isLoading.value = false;
      debugPrint("---------- $apiEndPoint  getCoursesApi End ----------");
    }
  }
}
