import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ielts_dashboard/home_module/model/user_attendance_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class UserAttendanceController extends GetxController with StateMixin<UserAttendanceModel> {
  getUserAttendance() async {
    const apiEndPoint = APIEndPoints.userAttendance;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {

      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("MyAttendanceController => getUserAttendance > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = UserAttendanceModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getUserAttendance End With Error ----------");
      debugPrint("MyAttendanceController => getUserAttendance > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getUserAttendance End ----------");
    }
  }
}
