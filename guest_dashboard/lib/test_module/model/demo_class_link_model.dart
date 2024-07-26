class DemoClassLinkModel {
  DemoClassLinkModel({
    this.message,
    this.status,
    this.result,
  });

  DemoClassLinkModel.fromJson(dynamic json) {
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
    this.link,
    this.successUrl,
  });

  Result.fromJson(dynamic json) {
    link = json['link'];
    successUrl = json['success_url'];
  }

  String? link;
  String? successUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['link'] = link;
    map['success_url'] = successUrl;
    return map;
  }
}
