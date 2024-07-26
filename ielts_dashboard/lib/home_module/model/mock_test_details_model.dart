class MockTestDetailsModel {
  MockTestDetailsModel({
    this.status,
    this.result,
  });

  MockTestDetailsModel.fromJson(dynamic json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  num? status;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    this.tests,
  });

  Result.fromJson(dynamic json) {
    if (json['tests'] != null) {
      tests = [];
      json['tests'].forEach((v) {
        tests?.add(Tests.fromJson(v));
      });
    }
  }
  List<Tests>? tests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tests != null) {
      map['tests'] = tests?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Tests {
  Tests({
    this.title,
    this.src,
    this.duration,
    this.section,
    this.questions,
    this.testStatus,
    this.result,
    this.testId,
  });

  Tests.fromJson(dynamic json) {
    title = json['title'];
    src = json['src'];
    duration = json['duration'];
    section = json['section'];
    questions = json['questions'];
    testStatus = json['testStatus'];
    result = json['result'];
    testId = json['test_id'];
  }
  String? title;
  String? src;
  String? duration;
  String? section;
  String? questions;
  String? testStatus;
  dynamic result;
  num? testId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['src'] = src;
    map['duration'] = duration;
    map['section'] = section;
    map['questions'] = questions;
    map['testStatus'] = testStatus;
    map['result'] = result;
    map['test_id'] = testId;
    return map;
  }
}
