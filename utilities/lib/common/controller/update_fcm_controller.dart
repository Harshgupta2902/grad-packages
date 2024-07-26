import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class UpdateFcmController extends GetxController {
  updateFcm({required String? token}) async {
    const apiEndPoint = APIEndPoints.updateFcmToken;
    debugPrint("---------- $apiEndPoint updateFcm Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {"fcm_token": token},
      );

      debugPrint("UpdateFcmController => updateFcm > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
    } catch (error) {
      debugPrint("---------- $apiEndPoint updateFcm End With Error ----------");
      debugPrint("UpdateFcmController => updateFcm > Error $error ");
    } finally {
      debugPrint("---------- $apiEndPoint updateFcm End ----------");
    }
  }
}
