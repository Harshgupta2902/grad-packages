import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/models/get_comments_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class GetCommentsController extends GetxController with StateMixin<GetCommentsModel> {
  getComments({required String applicationId}) async {
    const apiEndPoint = APIEndPoints.getComments;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {
          'application_id': applicationId,
        },
      );

      debugPrint("GetCommentsController => getComments > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      final modal = GetCommentsModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getComments End With Error ----------");
      debugPrint("GetCommentsController => getComments > Error $error ");
    } finally {
      debugPrint("---------- $apiEndPoint getComments End ----------");
    }
  }
}
