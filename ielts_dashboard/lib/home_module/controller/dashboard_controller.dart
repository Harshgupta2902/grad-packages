import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ielts_dashboard/home_module/model/dashboard_data_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class DashboardController extends GetxController with StateMixin<DashboardDataModel> {
  getDashboardData() async {
    const apiEndPoint = APIEndPoints.dashboardData;
    debugPrint("---------- $apiEndPoint dashboardData Start ----------");

    try {
      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("DashboardController => dashboardData > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = DashboardDataModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint dashboardData End With Error ----------");
      debugPrint("DashboardController => dashboardData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint dashboardData End ----------");
    }
  }
}
