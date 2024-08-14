import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:guest_dashboard/test_module/model/get_order_id_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class GetOrderIdController extends GetxController with StateMixin<GetOrderIdModel> {
  RxBool isLoading = RxBool(false);
  getOrderId({String? code, String? testTitle, String? testId}) async {
    const apiEndPoint = APIEndPoints.getOrderId;
    debugPrint("---------- $apiEndPoint getOrderId Start ----------");
    Map<String, dynamic> postData = {};
    try {
      if (code != null) {
        postData = {'code': code};
      } else if (testTitle != null) {
        postData = {'testCardTitle': testTitle, "testId": testId};
      } else {
        postData = {};
      }

      isLoading.value = true;
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: postData,
      );

      debugPrint("GetOrderIdController => getOrderId > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = GetOrderIdModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getOrderId End With Error ----------");
      debugPrint("GetOrderIdController => getOrderId > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      isLoading.value = false;
      debugPrint("---------- $apiEndPoint getOrderId End ----------");
    }
  }
}
