import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:guest_dashboard/test_module/model/buy_plans_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class BuyPlansController extends GetxController with StateMixin<BuyPlansModel> {
  getPlansData() async {
    const apiEndPoint = APIEndPoints.getPlansData;
    debugPrint("---------- $apiEndPoint getPlansData Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {},
      );

      debugPrint("BuyPlansController => getPlansData > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = BuyPlansModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getPlansData End With Error ----------");
      debugPrint("BuyPlansController => getPlansData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getPlansData End ----------");
    }
  }
}
