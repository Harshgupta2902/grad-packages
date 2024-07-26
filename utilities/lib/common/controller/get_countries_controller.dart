import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:utilities/common/model/get_country_model.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class GetCountriesController extends GetxController with StateMixin<GetCountryModel> {
  getCountries() async {
    const apiEndPoint = APIEndPoints.getCountry;
    debugPrint("---------- $apiEndPoint getCountries Start ----------");

    try {
      final response = await postRequest(apiEndPoint: apiEndPoint, postData: {});

      debugPrint("GetCountriesController => getCountries > Success  $response");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = GetCountryModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint getCountries End With Error ----------");
      debugPrint("GetCountriesController => getCountries > Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getCountries End ----------");
    }
  }
}
