// import 'package:flutter/material.dart';
// import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
// import 'package:crypto/crypto.dart';
// import 'dart:convert';
//
// class HashService {
//   static const merchantSalt = "QuWdn710AllSGSWKuiH1QQyoQ1HQeHBm"; // Add your Salt here.
//   static const merchantSecretKey = "m42XBz"; // Add Merchant Secret Key - Optional
//
//   static Map generateHash(Map response) {
//     var hashName = response[PayUHashConstantsKeys.hashName];
//     var hashStringWithoutSalt = response[PayUHashConstantsKeys.hashString];
//     var hashType = response[PayUHashConstantsKeys.hashType];
//     var postSalt = response[PayUHashConstantsKeys.postSalt];
//     var hash = "";
//     if (hashType == PayUHashConstantsKeys.hashVersionV2) {
//       hash = getHmacSHA256Hash(hashStringWithoutSalt, merchantSalt);
//     } else if (hashName == PayUHashConstantsKeys.mcpLookup) {
//       hash = getHmacSHA1Hash(hashStringWithoutSalt, merchantSecretKey);
//     } else {
//       var hashDataWithSalt = hashStringWithoutSalt + merchantSalt;
//       if (postSalt != null) {
//         hashDataWithSalt = hashDataWithSalt + postSalt;
//       }
//       hash = getSHA512Hash(hashDataWithSalt);
//     }
//     var finalHash = {hashName: hash};
//     debugPrint("final Hash::::::::::::::::::::::::::$finalHash");
//
//     return finalHash;
//   }
//
//   static String getSHA512Hash(String hashData) {
//     var bytes = utf8.encode(hashData);
//     var hash = sha512.convert(bytes);
//     return hash.toString();
//   }
//
//   static String getHmacSHA256Hash(String hashData, String salt) {
//     var key = utf8.encode(salt);
//     var bytes = utf8.encode(hashData);
//     final hmacSha256 = Hmac(sha256, key).convert(bytes).bytes;
//     final hmacBase64 = base64Encode(hmacSha256);
//     return hmacBase64;
//   }
//
//   static String getHmacSHA1Hash(String hashData, String salt) {
//     var key = utf8.encode(salt);
//     var bytes = utf8.encode(hashData);
//     var hmacSha1 = Hmac(sha1, key); // HMAC-SHA1
//     var hash = hmacSha1.convert(bytes);
//     return hash.toString();
//   }
// }
//
// class PayUTestCredentials {
//   static const merchantKey = "m42XBz"; // Add you Merchant Key
//   static const iosSurl = "https:///www.payumoney.com/mobileapp/payumoney/success.php";
//   static const iosFurl = "https:///www.payumoney.com/mobileapp/payumoney/failure.php";
//   static const androidSurl = "https:///www.payumoney.com/mobileapp/payumoney/success.php";
//   static const androidFurl = "https:///www.payumoney.com/mobileapp/payumoney/failure.php";
//
//   static const merchantAccessKey = ""; //Add Merchant Access Key - Optional
//   static const sodexoSourceId = ""; //Add sodexo Source Id - Optional
// }
//
// class PayUParams {
//   static Map createPayUPaymentParams() {
//
//     var additionalParam = {
//       PayUAdditionalParamKeys.udf1: "udf1",
//       PayUAdditionalParamKeys.udf2: "udf2",
//       PayUAdditionalParamKeys.udf3: "udf3",
//       PayUAdditionalParamKeys.udf4: "udf4",
//       PayUAdditionalParamKeys.udf5: "udf5",
//       PayUAdditionalParamKeys.merchantAccessKey: PayUTestCredentials.merchantAccessKey,
//       PayUAdditionalParamKeys.sourceId: PayUTestCredentials.sodexoSourceId,
//     };
//
//     var spitPaymentDetails = {
//       "type": "absolute",
//       "splitInfo": {
//         PayUTestCredentials.merchantKey: {
//           "aggregatorSubTxnId": "1234567540099887766650091", //unique for each transaction
//           "aggregatorSubAmt": "1"
//         }
//       }
//     };
//
//     var payUPaymentParams = {
//       PayUPaymentParamKey.key: PayUTestCredentials.merchantKey,
//       PayUPaymentParamKey.amount: "2999",
//       PayUPaymentParamKey.productInfo: "iphone",
//       PayUPaymentParamKey.firstName: "murtaza",
//       PayUPaymentParamKey.email: "murtazaamet53@gmail.com",
//       PayUPaymentParamKey.phone: "9999999999",
//       PayUPaymentParamKey.ios_surl: PayUTestCredentials.iosSurl,
//       PayUPaymentParamKey.ios_furl: PayUTestCredentials.iosFurl,
//       PayUPaymentParamKey.android_surl: PayUTestCredentials.androidSurl,
//       PayUPaymentParamKey.android_furl: PayUTestCredentials.androidFurl,
//       PayUPaymentParamKey.environment: "0", //0 => Production 1 => Test
//       PayUPaymentParamKey.userCredential: "1000",
//       PayUPaymentParamKey.transactionId: "txnid",
//       PayUPaymentParamKey.additionalParam: additionalParam,
//       PayUPaymentParamKey.enableNativeOTP: true,
//       PayUPaymentParamKey.splitPaymentDetails: json.encode(spitPaymentDetails),
//       PayUPaymentParamKey.userToken: "", //Pass a unique token to fetch offers. - Optional
//     };
//
//     return payUPaymentParams;
//   }
//
//   static Map createPayUConfigParams() {
//     var paymentModesOrder = [
//       {"Wallets": "PHONEPE"},
//       {"UPI": "TEZ"},
//       {"Wallets": ""},
//       {"EMI": ""},
//       {"NetBanking": ""},
//     ];
//
//     var cartDetails = [
//       {"GST": "5%"},
//       {"Delivery Date": "25 Dec"},
//       {"Status": "In Progress"}
//     ];
//
//     var customNotes = [
//       {
//         "custom_note": "Its Common custom note for testing purpose",
//         "custom_note_category": [PayUPaymentTypeKeys.emi, PayUPaymentTypeKeys.card]
//       },
//       {"custom_note": "Payment options custom note", "custom_note_category": null}
//     ];
//
//     var payUCheckoutProConfig = {
//       PayUCheckoutProConfigKeys.primaryColor: "#4994EC",
//       PayUCheckoutProConfigKeys.secondaryColor: "#FFFFFF",
//       PayUCheckoutProConfigKeys.merchantName: "PayU",
//       PayUCheckoutProConfigKeys.merchantLogo: "logo",
//       PayUCheckoutProConfigKeys.showExitConfirmationOnCheckoutScreen: true,
//       PayUCheckoutProConfigKeys.showExitConfirmationOnPaymentScreen: true,
//       PayUCheckoutProConfigKeys.cartDetails: cartDetails,
//       PayUCheckoutProConfigKeys.paymentModesOrder: paymentModesOrder,
//       PayUCheckoutProConfigKeys.merchantResponseTimeout: 30000,
//       PayUCheckoutProConfigKeys.customNotes: customNotes,
//       PayUCheckoutProConfigKeys.autoSelectOtp: true,
//       // PayUCheckoutProConfigKeys.enforcePaymentList: enforcePaymentList,
//       PayUCheckoutProConfigKeys.waitingTime: 30000,
//       PayUCheckoutProConfigKeys.autoApprove: true,
//       PayUCheckoutProConfigKeys.merchantSMSPermission: true,
//       PayUCheckoutProConfigKeys.showCbToolbar: true,
//     };
//     return payUCheckoutProConfig;
//   }
// }
