class IeltsPracticeTestModel {
  IeltsPracticeTestModel({
    this.status,
    this.msg,
    this.tests,
    this.testname,
  });

  IeltsPracticeTestModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['tests'] != null) {
      tests = [];
      json['tests'].forEach((v) {
        tests?.add(Tests.fromJson(v));
      });
    }
    testname = json['testname'];
  }
  num? status;
  String? msg;
  List<Tests>? tests;
  String? testname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (tests != null) {
      map['tests'] = tests?.map((v) => v.toJson()).toList();
    }
    map['testname'] = testname;
    return map;
  }
}

class Tests {
  Tests({
    this.testId,
    this.testTitle,
    this.encodeTestId,
    this.availableAt,
    this.testIs,
    this.src,
    this.status,
    this.band,
    this.testPrice,
    this.testDuration,
    this.testQuestion,
    this.listeningTestScore,
    this.writingTestScore,
    this.readingTestScore,
    this.speakingTestScore,
    this.successUrl,
  });

  Tests.fromJson(dynamic json) {
    testId = json['test_id'];
    testTitle = json['test_title'];
    encodeTestId = json['encode_test_id'];
    availableAt = json['available_at'];
    testIs = json['test_is'];
    src = json['src'];
    status = json['status'];
    band = json['band'];
    testPrice = json['test_price'];
    testDuration = json['test_duration'];
    testQuestion = json['test_question'];
    listeningTestScore = json['listening_test_score'];
    writingTestScore = json['writing_test_score'];
    readingTestScore = json['reading_test_score'];
    speakingTestScore = json['speaking_test_score'];
    successUrl = json['success_url'];
  }
  num? testId;
  String? encodeTestId;
  String? testTitle;
  String? availableAt;
  num? testIs;
  String? src;
  String? status;
  dynamic band;
  String? testPrice;
  String? testDuration;
  num? testQuestion;
  num? listeningTestScore;
  num? writingTestScore;
  num? readingTestScore;
  num? speakingTestScore;
  String? successUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['test_id'] = testId;
    map['test_title'] = testTitle;
    map['encode_test_id'] = encodeTestId;
    map['available_at'] = availableAt;
    map['test_is'] = testIs;
    map['src'] = src;
    map['status'] = status;
    map['band'] = band;
    map['test_price'] = testPrice;
    map['test_duration'] = testDuration;
    map['test_question'] = testQuestion;
    map['listening_test_score'] = listeningTestScore;
    map['writing_test_score'] = writingTestScore;
    map['reading_test_score'] = readingTestScore;
    map['success_url'] = successUrl;
    map['speaking_test_score'] = speakingTestScore;
    return map;
  }
}
