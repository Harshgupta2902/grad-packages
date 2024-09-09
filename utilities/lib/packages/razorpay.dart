import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:utilities/common/controller/payment_controller.dart';
import 'package:utilities/dio/api_end_points.dart';
import 'package:utilities/packages/dialogs.dart';

typedef VoidCallback = void Function();
final _paymentController = Get.put(PaymentController());

openRazorpay({
  required num amount,
  required String description,
  required String orderId,
  required BuildContext context,
  required VoidCallback onTap,
  String? testName,
  String? currency,
  String? testId,
  String? testTitle,
  required Map<String, String> prefill,
}) {
  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    Dialogs.showLoadingDialog(context);

    try {
      if (response.paymentId == null) {
        return;
      }
      debugPrint('postRequest. Payment ID: ${response.paymentId}');
      await _paymentController.generatePayment(
        postData: {
          "order_id": orderId,
          "payment_gateway_id": 4,
          "currency_symbol": "INR",
          "transaction_id": response.paymentId,
          "amount": amount,
          "testId": testId,
          "testname": testName,
          "testCardTitle": testTitle
        },
      ).then((value) {
        onTap();
      });
    } catch (error) {
      debugPrint('error $error');
    }
  }

  void handlePaymentError(PaymentFailureResponse response) {
    try {
      Dialogs.cancelledDialog(context);

      debugPrint('Payment Error. Code: ${response.code}, Message: ${response.message}');
    } catch (error) {
      debugPrint('Payment Error. $error');
    }
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    try {
      debugPrint('External Wallet Selected. Wallet Name: ${response.walletName}');
    } catch (error) {
      debugPrint('Payment Error. $error');
    }
  }

  Razorpay razorpay = Razorpay();
  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

  var options = {
    'key': APIEndPoints.base == APIEndPoints.live
        ? 'rzp_live_cbnFxnhacRizR0'
        : 'rzp_test_9Oqxns8kejKZpZ',
    // 'key': 'rzp_test_9Oqxns8kejKZpZ',
    'amount': (amount * 100), // Amount in smallest currency unit (e.g., paise for INR)
    'currency': currency ?? "INR",
    'name': 'Gradding',
    'description': description,
    'prefill': prefill,
  };

  try {
    razorpay.open(options);
  } catch (e) {
    debugPrint('Error: $e');
  }
}
