import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:utilities/dio/api_end_points.dart';

class NewClient {
  Dio init() {
    final prefs = GetStorage();
    var token = prefs.read('TOKEN');
    Dio dio = Dio();
    dio.options.baseUrl = APIEndPoints.base;
    dio.options.headers["Authorization"] = 'Bearer ${token ?? ""}';
    debugPrint("token  : : :: : : : $token");
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}
