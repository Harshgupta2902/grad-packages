import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class DeleteDocumentController extends GetxController {
  RxBool isLoading = RxBool(false);
  Future<dynamic> deleteDocument({required String docId}) async {
    const apiEndPoint = APIEndPoints.documentDelete;
    isLoading.value = true;
    debugPrint("---------- $apiEndPoint  Start ----------");

    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: {
          'document_id': docId,
        },
      );

      debugPrint("deleteDocumentList => deleteDocument > Success  ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      return response.data;

    } catch (error) {
      debugPrint("---------- $apiEndPoint deleteDocument End With Error ----------");
      debugPrint("deleteDocumentList => deleteDocument > Error $error ");
    } finally {
      isLoading.value = false;

      debugPrint("---------- $apiEndPoint deleteDocument End ----------");
    }
  }
}
