class UserAttendanceModel {
  UserAttendanceModel({
    this.status,
    this.msg,
    this.result,
  });

  UserAttendanceModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }

  num? status;
  String? msg;
  List<Result>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Result {
  Result({
    this.attend,
    this.classDate,
    this.classId,
  });

  Result.fromJson(dynamic json) {
    attend = json['attend'];
    classDate = json['class_date'];
    classId = json['class_id'];
  }

  num? attend;
  String? classDate;
  num? classId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attend'] = attend;
    map['class_date'] = classDate;
    map['class_id'] = classId;
    return map;
  }
}
