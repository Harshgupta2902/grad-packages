import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class UpdateExamNameController extends GetxController {
  Future<dynamic> updateExamName({required String? testType, required String? subTestType}) async {
    const apiEndPoint = APIEndPoints.updateExamName;
    debugPrint("---------- $apiEndPoint updateExamName Start ----------");
    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {"test_type": "$testType", "sub_test_type": "$subTestType"},
      );

      debugPrint("UpdateExamNameController =>  updateExamName > Success ${response.data} ");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      return response.data;
    } catch (error) {
      debugPrint("---------- $apiEndPoint  updateExamName End With Error ----------");
      debugPrint(" UpdateExamNameController =>  updateExamName > Error $error ");
    } finally {
      debugPrint("---------- $apiEndPoint  updateExamName End ----------");
    }
  }
}
