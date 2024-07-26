import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class ApplyCourseController extends GetxController {
  Future<dynamic> applyCourse({
    required String courseId,
    required String universityId,
    required String id,
  }) async {
    const apiEndPoint = APIEndPoints.applyCourse;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {
          'course_id': courseId,
          'university_id': universityId,
          'id': id,
        },
      );

      debugPrint("ApplyCourseController => applyCourse > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      return response.data;
    } catch (error) {
      debugPrint("---------- $apiEndPoint applyCourse End With Error ----------");
      debugPrint("ApplyCourseController => applyCourse > Error $error ");
    } finally {
      debugPrint("---------- $apiEndPoint applyCourse End ----------");
    }
  }
}
