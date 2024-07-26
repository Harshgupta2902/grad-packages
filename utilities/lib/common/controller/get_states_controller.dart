import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:utilities/common/model/get_states_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class GetStatesController extends GetxController with StateMixin<GetStatesModel> {
  RxBool isLoggingIn = RxBool(false);

  getStates({required String countyId}) async {
    const apiEndPoint = APIEndPoints.getStates;
    debugPrint("---------- $apiEndPoint  Start ----------");
    isLoggingIn.value = true;

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {
          "user_country_id": countyId,
        },
      );

      debugPrint("GetStatesController => getStates > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      final modal = GetStatesModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getStates End With Error ----------");
      debugPrint("GetStatesController => getStates > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getStates End ----------");
      isLoggingIn.value = false;
    }
  }
}
