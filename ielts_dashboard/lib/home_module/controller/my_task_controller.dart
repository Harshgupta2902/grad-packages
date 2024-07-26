import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ielts_dashboard/home_module/model/my_tasks_model.dart';

import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class MyTasksController extends GetxController with StateMixin<MyTasksModel> {
  getMyTasks() async {
    const apiEndPoint = APIEndPoints.myTasks;
    debugPrint("---------- $apiEndPoint getMyTasks Start ----------");

    try {
      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("MyTasksController => getMyTasks > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = MyTasksModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint dashboardData End With Error ----------");
      debugPrint("MyTasksController => getMyTasks > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getMyTasks End ----------");
    }
  }
}
