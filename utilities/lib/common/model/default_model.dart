class DefaultModel {
  DefaultModel({
    this.result,
    this.message,
    this.status,
  });

  DefaultModel.fromJson(dynamic json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    message = json['message'];
    status = json['status'];
  }
  Result? result;
  String? message;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}

class Result {
  Result({
    this.forceUpdate,
    this.softUpdate,
    this.buildNo,
    this.downloadUrl,
    this.path,
    this.paymentType,
    this.privacy,
    this.terms,
  });

  Result.fromJson(dynamic json) {
    forceUpdate = json['force_update'];
    softUpdate = json['soft_update'];
    buildNo = json['build_no'];
    downloadUrl = json['download_url'];
    path = json['path'];
    paymentType = json['payment_type'];
    privacy = json['privacy'];
    terms = json['terms'];
  }
  num? forceUpdate;
  num? softUpdate;
  num? buildNo;
  String? downloadUrl;
  String? path;
  String? privacy;
  String? terms;
  int? paymentType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['force_update'] = forceUpdate;
    map['soft_update'] = softUpdate;
    map['build_no'] = buildNo;
    map['download_url'] = downloadUrl;
    map['path'] = path;
    map['payment_type'] = paymentType;
    map['privacy'] = privacy;
    map['terms'] = terms;
    return map;
  }
}
