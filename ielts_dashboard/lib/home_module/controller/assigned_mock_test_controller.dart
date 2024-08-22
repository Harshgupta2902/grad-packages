import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:ielts_dashboard/home_module/model/ielts_mock_test_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class AssignedMockTestController extends GetxController with StateMixin<IeltsMockTestModel> {
  getIeltsMockTests({conditionKey}) async {
    const apiEndPoint = APIEndPoints.assignedMockTestV1;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      change(null, status: RxStatus.loading());
      final response = await getRequest(apiEndPoint: apiEndPoint);

      debugPrint("AssignedMockTestController => $apiEndPoint > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = IeltsMockTestModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint End With Error ----------");
      debugPrint("AssignedMockTestController => getIeltsMockTests > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint End ----------");
    }
  }


}
