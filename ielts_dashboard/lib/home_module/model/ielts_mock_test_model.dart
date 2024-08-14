import 'package:flutter/material.dart';

class IeltsMockTestModel {
  IeltsMockTestModel({
    this.status,
    this.msg,
    this.tests,
    this.buyMockTests,
    this.order,
    this.testname,
    this.free,
  });

  IeltsMockTestModel.fromJson(dynamic json) {
    try {
      status = json['status'];
      msg = json['msg'];
      if (json['tests'] != null) {
        tests = [];
        json['tests'].forEach((v) {
          tests?.add(Tests.fromJson(v));
        });
      }
      if (json['buyMockTests'] != null) {
        buyMockTests = [];
        json['buyMockTests'].forEach((v) {
          buyMockTests?.add(BuyMockTests.fromJson(v));
        });
      }
      order = json['order'];
      testname = json['testname'];
      free = json['free'] != null ? json['free'].cast<num>() : [];
    } catch (e) {
      debugPrint("IELTSMOCKTEST ERROR FOR MODEL =>:::::$e");
    }
  }
  num? status;
  String? msg;
  List<Tests>? tests;
  List<BuyMockTests>? buyMockTests;
  bool? order;
  String? testname;
  List<num>? free;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (tests != null) {
      map['tests'] = tests?.map((v) => v.toJson()).toList();
    }
    if (buyMockTests != null) {
      map['buyMockTests'] = buyMockTests?.map((v) => v.toJson()).toList();
    }
    map['order'] = order;
    map['testname'] = testname;
    map['free'] = free;
    return map;
  }
}

class BuyMockTests {
  BuyMockTests({
    this.testTitle,
    this.testDuration,
    this.testPrice,
    this.testQuestion,
    this.testIs,
    this.testId,
  });

  BuyMockTests.fromJson(dynamic json) {
    testTitle = json['test_title'];
    testDuration = json['test_duration'];
    testPrice = json['test_price'];
    testQuestion = json['test_question'];
    testIs = json['test_is'];
    testId = json['test_id'];
  }
  String? testTitle;
  String? testDuration;
  String? testPrice;
  num? testQuestion;
  num? testIs;
  num? testId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['test_title'] = testTitle;
    map['test_duration'] = testDuration;
    map['test_price'] = testPrice;
    map['test_question'] = testQuestion;
    map['test_is'] = testIs;
    map['test_id'] = testId;
    return map;
  }
}

class Tests {
  Tests({
    this.testId,
    this.testTitle,
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
  });

  Tests.fromJson(dynamic json) {
    testId = json['test_id'];
    testTitle = json['test_title'];
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
  }
  num? testId;
  String? testTitle;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['test_id'] = testId;
    map['test_title'] = testTitle;
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
    map['speaking_test_score'] = speakingTestScore;
    return map;
  }
}
