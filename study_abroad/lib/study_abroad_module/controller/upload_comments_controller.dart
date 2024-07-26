import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class UploadCommentsController extends GetxController {
  Future<dynamic> uploadComments({required String applicationId, required String comments}) async {
    const apiEndPoint = APIEndPoints.uploadComments;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {
          'application_id': applicationId,
          'comment' : comments
        },
      );

      debugPrint("UploadCommentsController => uploadComments > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      return response.data;
    } catch (error) {
      debugPrint("---------- $apiEndPoint uploadComments End With Error ----------");
      debugPrint("UploadCommentsController => uploadComments > Error $error ");
    } finally {
      debugPrint("---------- $apiEndPoint uploadComments End ----------");
    }
  }
}
