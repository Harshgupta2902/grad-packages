class GetOrderIdModel {
  GetOrderIdModel({
    this.message,
    this.status,
    this.result,
  });

  GetOrderIdModel.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? message;
  num? status;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    this.orderId,
    this.amount,
    this.name,
    this.phone,
    this.email,
  });

  Result.fromJson(dynamic json) {
    orderId = json['orderId'];
    amount = json['amount'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }
  num? orderId;
  num? amount;
  String? name;
  String? phone;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = orderId;
    map['amount'] = amount;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    return map;
  }
}
