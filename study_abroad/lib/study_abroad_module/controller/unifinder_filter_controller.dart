import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/models/filter_data_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class UniFinderFilterController extends GetxController with StateMixin<FilterDataModel> {
  RxMap<String, List<String>> pageFilter = RxMap();
  RxMap<String, List<String>> tempFilter = RxMap();

  getCoursesFilterApi() async {
    const apiEndPoint = APIEndPoints.coursesFilter;

    change(null, status: RxStatus.loading());
    debugPrint("---------- $apiEndPoint getCoursesFilterApi Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {},
      );

      debugPrint("UniFinderController =>  getCoursesFilterApi > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = FilterDataModel.fromJson(response.data);

      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint  getCoursesFilterApi End With Error ----------");
      debugPrint(" UniFinderController =>  getCoursesFilterApi > Error $error ");
      change(null, status: RxStatus.error(error.toString()));
    } finally {
      debugPrint("---------- $apiEndPoint  getCoursesFilterApi End ----------");
    }
  }

  getUniversityFilterApi() async {
    const apiEndPoint = APIEndPoints.universityFilter;

    change(null, status: RxStatus.loading());
    debugPrint("---------- $apiEndPoint getUniversityFilterApi Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {},
      );

      debugPrint("UniFinderController =>  getUniversityFilterApi > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = FilterDataModel.fromJson(response.data);

      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint  getUniversityFilterApi End With Error ----------");
      debugPrint(" UniFinderController =>  getUniversityFilterApi > Error $error ");
      change(null, status: RxStatus.error(error.toString()));
    } finally {
      debugPrint("---------- $apiEndPoint  getUniversityFilterApi End ----------");
    }
  }
}
