import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:utilities/common/model/profile_model_data.dart';

import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class ProfileController extends GetxController with StateMixin<ProfileModelData> {
  getProfileData() async {
    const apiEndPoint = APIEndPoints.profile;
    debugPrint("---------- $apiEndPoint getProfileData Start ----------");

    try {
      change(null, status: RxStatus.loading());

      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("ProfileController => getProfileData > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = ProfileModelData.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getProfileData End With Error ----------");
      debugPrint("ProfileController => getProfileData > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getProfileData End ----------");
    }
  }
}
