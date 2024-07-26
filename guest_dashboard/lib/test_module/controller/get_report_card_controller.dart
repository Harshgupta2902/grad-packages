import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:guest_dashboard/test_module/model/report_card_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class GetReportCardController extends GetxController with StateMixin<ReportCardModel> {
  getReportCard() async {
    const apiEndPoint = APIEndPoints.getReportCard;
    debugPrint("---------- $apiEndPoint getReportCard Start ----------");

    try {
      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("GetReportCardController => getReportCard > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = ReportCardModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getReportCard End With Error ----------");
      debugPrint("GetReportCardController => getReportCard > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getReportCard End ----------");
    }
  }
}
