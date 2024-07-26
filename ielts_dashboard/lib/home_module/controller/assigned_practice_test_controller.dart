import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ielts_dashboard/home_module/model/ielts_practice_test_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class AssignedPractiseTestController extends GetxController
    with StateMixin<IeltsPracticeTestModel> {
  getPracticeTests() async {
    const apiEndPoint = APIEndPoints.assignedPracticeTest;

    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      change(null, status: RxStatus.loading());
      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("AssignedPractiseTestController => $apiEndPoint > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = IeltsPracticeTestModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint End With Error ----------");
      debugPrint("AssignedPractiseTestController => getPracticeTests > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint End ----------");
    }
  }
}
