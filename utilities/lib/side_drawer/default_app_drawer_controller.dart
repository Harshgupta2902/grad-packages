import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';
import 'package:utilities/side_drawer/default_custom_drawer_model.dart';

class GetMenuItemsController extends GetxController with StateMixin<DefaultCustomDrawerModel> {
  getMenuItems({required String path}) async {
    const apiEndPoint = APIEndPoints.menuItems;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {
          'page': path,
        },
      );

      debugPrint("GetMenuItemsController => getMenuItems > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = DefaultCustomDrawerModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getMenuItems End With Error ----------");
      debugPrint("GetMenuItemsController => getMenuItems > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getMenuItems End ----------");
    }
  }
}
