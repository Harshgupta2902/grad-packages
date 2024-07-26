import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:utilities/common/model/get_city_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class GetCityController extends GetxController with StateMixin<GetCityModel> {
  RxBool isLoggingIn = RxBool(false);

  getCities({required String stateId}) async {
    const apiEndPoint = APIEndPoints.getCities;
    debugPrint("---------- $apiEndPoint  Start ----------");
    isLoggingIn.value = true;

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {
          "user_state_id": stateId,
        },
      );

      debugPrint("GetCityController => getCities > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      final modal = GetCityModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getCities End With Error ----------");
      debugPrint("GetCityController => getCities > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getCities End ----------");
      isLoggingIn.value = false;
    }
  }
}
