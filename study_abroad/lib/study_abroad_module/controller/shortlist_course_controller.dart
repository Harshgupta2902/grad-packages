import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class ShortlistCourseController extends GetxController {
  Future<dynamic> shortlistCourse({required String courseId, required bool status}) async {
    const apiEndPoint = APIEndPoints.shortlistCourse;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {
          'course_id': courseId,
          'status': jsonEncode(status),
        },
      );

      debugPrint("ShortlistCourseController => shortlistCourse > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      return response.data;
    } catch (error) {
      debugPrint("---------- $apiEndPoint shortlistCourse End With Error ----------");
      debugPrint("ShortlistCourseController => shortlistCourse > Error $error ");
    } finally {
      debugPrint("---------- $apiEndPoint shortlistCourse End ----------");
    }
  }
}
