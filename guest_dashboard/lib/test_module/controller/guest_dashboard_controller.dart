import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guest_dashboard/test_module/model/guest_dashboard_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class GuestDashboardController extends GetxController with StateMixin<GuestDashboardModel> {
  getGuestDashboardData() async {
    const apiEndPoint = APIEndPoints.guestDashboard;

    debugPrint("---------- $apiEndPoint getGuestDashboardData Start ----------");

    try {
      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("GuestDashboardController =>  getGuestDashboardData > Success ${response.data} ");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = GuestDashboardModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint  getGuestDashboardData End With Error ----------");
      debugPrint(" GuestDashboardController =>  getGuestDashboardData > Error $error ");
      change(null, status: RxStatus.error(error.toString()));
    } finally {
      debugPrint("---------- $apiEndPoint  getGuestDashboardData End ----------");
    }
  }
}
