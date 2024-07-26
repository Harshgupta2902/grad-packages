class IeltsMockTestModel {
  IeltsMockTestModel({
    this.status,
    this.msg,
    this.result,
  });

  IeltsMockTestModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  num? status;
  String? msg;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    this.card,
    this.tests,
    this.username,
  });

  Result.fromJson(dynamic json) {
    card = json['card'] != null ? Card.fromJson(json['card']) : null;
    if (json['tests'] != null) {
      tests = [];
      json['tests'].forEach((v) {
        tests?.add(Tests.fromJson(v));
      });
    }
    username = json['username'];
  }
  Card? card;
  List<Tests>? tests;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (card != null) {
      map['card'] = card?.toJson();
    }
    if (tests != null) {
      map['tests'] = tests?.map((v) => v.toJson()).toList();
    }
    map['username'] = username;
    return map;
  }
}

class Tests {
  Tests({
    this.name,
    this.testId,
    this.status,
    this.band,
  });

  Tests.fromJson(dynamic json) {
    name = json['name'];
    testId = json['test_id'];
    status = json['status'];
    band = json['band'];
  }
  String? name;
  String? testId;
  String? status;
  dynamic band;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['test_id'] = testId;
    map['status'] = status;
    map['band'] = band;
    return map;
  }
}

class Card {
  Card({
    this.title,
    this.desc,
    this.complete,
    this.total,
  });

  Card.fromJson(dynamic json) {
    title = json['title'];
    desc = json['desc'];
    complete = json['complete'];
    total = json['total'];
  }
  String? title;
  String? desc;
  num? complete;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['desc'] = desc;
    map['complete'] = complete;
    map['total'] = total;
    return map;
  }
}
