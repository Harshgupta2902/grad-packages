import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:guest_dashboard/test_module/model/demo_class_link_model.dart';

import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class DemoClassLinkController extends GetxController with StateMixin<DemoClassLinkModel> {
  demoClassLink() async {
    const apiEndPoint = APIEndPoints.demoClassLink;
    debugPrint("---------- $apiEndPoint demoClassLink Start ----------");

    try {
      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("DemoClassLinkController => demoClassLink > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = DemoClassLinkModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint demoClassLink End With Error ----------");
      debugPrint("DemoClassLinkController => demoClassLink > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint demoClassLink End ----------");
    }
  }
}
