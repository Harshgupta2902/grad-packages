import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utilities/common/model/default_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class DefaultController extends GetxController with StateMixin<DefaultModel> {
  getDefaultData() async {
    const apiEndPoint = APIEndPoints.defaultApi;

    debugPrint("---------- $apiEndPoint getDefaultData Start ----------");

    try {
      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("DefaultController =>  getDefaultData > Success $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ';
      }

      final modal = DefaultModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint  getDefaultData End With Error ----------");
      debugPrint(" DefaultController =>  getDefaultData > Error $error ");
      change(null, status: RxStatus.error(error.toString()));
    } finally {
      debugPrint("---------- $apiEndPoint  getDefaultData End ----------");
    }
  }
}
