class GetCommentsModel {
  GetCommentsModel({
    this.message,
    this.status,
    this.result,
  });

  GetCommentsModel.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }
  String? message;
  num? status;
  List<Result>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Result {
  Result({
    this.comment,
    this.type,
    this.createdAt,
  });

  Result.fromJson(dynamic json) {
    comment = json['comment'];
    type = json['type'];
    createdAt = json['created_at'];
  }
  String? comment;
  num? type;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comment'] = comment;
    map['type'] = type;
    map['created_at'] = createdAt;
    return map;
  }
}
