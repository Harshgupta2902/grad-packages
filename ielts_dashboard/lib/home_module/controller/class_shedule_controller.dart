import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:ielts_dashboard/home_module/model/class_shedule_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class ClassScheduleController extends GetxController with StateMixin<ClassScheduleModel> {
  getClassSchedule({required String start, required String end}) async {
    const apiEndPoint = APIEndPoints.classSchedule;
    debugPrint("---------- $apiEndPoint getClassSchedule Start ----------");

    try {
      final postData = {
        "start": start,
        "end": end,

        // "$data" : prev,
      };
      change(null, status: RxStatus.loading());

      final response = await postRequest(apiEndPoint: apiEndPoint, postData: postData);

      debugPrint("ClassScheduleController => getClassSchedule > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = ClassScheduleModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getClassSchedule End With Error ----------");
      debugPrint("ClassScheduleController => getClassSchedule > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getClassSchedule End ----------");
    }
  }
}
