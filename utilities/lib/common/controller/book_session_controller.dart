import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class BookSessionController extends GetxController {
  RxBool isLoading = RxBool(false);

  Future<dynamic> bookSession({required String slot, required String comment}) async {
    const apiEndPoint = APIEndPoints.bookSession;
    debugPrint("---------- $apiEndPoint  Start ----------");
    isLoading.value = true;

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {
          "slot": slot,
          "comment": comment,
          "source": "Mobile",
          "url": "home",
        },
      );

      debugPrint("BookSessionController => bookSession > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      return response.data['status'];
    } catch (error) {
      debugPrint("---------- $apiEndPoint bookSession End With Error ----------");
      debugPrint("BookSessionController => bookSession > Error $error ");
    } finally {
      debugPrint("---------- $apiEndPoint bookSession End ----------");
      isLoading.value = false;
    }
  }
}
