import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ielts_dashboard/home_module/model/mock_test_details_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class MockTestDetailsController extends GetxController with StateMixin<MockTestDetailsModel> {
  RxBool isLoading = RxBool(false);

  Future<Map<String, dynamic>?> mockTestDetails({required String? testId}) async {
    const apiEndPoint = APIEndPoints.mockTestDetails;
    debugPrint("---------- $apiEndPoint mockTestDetails Start ----------");
    isLoading.value = true;

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {
          'test_id': testId,
        },
      );

      debugPrint("MockTestDetailsController => mockTestDetails > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = MockTestDetailsModel.fromJson(response.data);
      change(modal, status: RxStatus.success());

      return response.data;
    } catch (error) {
      debugPrint("---------- $apiEndPoint mockTestDetails End With Error ----------");
      debugPrint("MockTestDetailsController => mockTestDetails > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      isLoading.value = false;
      debugPrint("---------- $apiEndPoint mockTestDetails End ----------");
    }
  }
}
