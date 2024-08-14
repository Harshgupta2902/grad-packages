import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/dio/api_request.dart';

class PaymentController extends GetxController {
  Future<String?> generatePayment(
      {String? amount,
      String? orderId,
      String? transactionId,
      Map<String, dynamic>? postData}) async {
    const apiEndPoint = APIEndPoints.generatePayment;
    debugPrint("---------- $apiEndPoint generatePayment Start ----------");
    try {
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: postData ??
            {
              "order_id": orderId,
              "payment_gateway_id": 4,
              "currency_symbol": "INR",
              "transaction_id": transactionId,
              "amount": amount
            },
      );
      debugPrint("PaymentController => generatePayment > Success  $response");
      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }
      return response.data['status'].toString();
    } catch (error) {
      debugPrint("---------- $apiEndPoint generatePayment End With Error ----------");
      debugPrint("PaymentController => generatePayment > Error $error ");
    } finally {
      debugPrint("---------- $apiEndPoint generatePayment End ----------");
    }
    return null;
  }
}
