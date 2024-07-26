class ReportCardModel {
  ReportCardModel({
    this.status,
    this.message,
    this.result,
  });

  ReportCardModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  num? status;
  String? message;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    this.tabs,
    this.bands,
    this.content,
    this.testTaken,
    this.averageBandScore,
  });

  Result.fromJson(dynamic json) {
    tabs = json['tabs'] != null ? json['tabs'].cast<String>() : [];
    bands = json['bands'] != null ? Bands.fromJson(json['bands']) : null;
    if (json['content'] != null) {
      content = [];
      json['content'].forEach((v) {
        content?.add(Content.fromJson(v));
      });
    }
    testTaken = json['test_taken'];
    averageBandScore = json['average_band_score'];
  }

  List<String>? tabs;
  Bands? bands;
  List<Content>? content;
  String? testTaken;
  String? averageBandScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tabs'] = tabs;
    if (bands != null) {
      map['bands'] = bands?.toJson();
    }
    if (content != null) {
      map['content'] = content?.map((v) => v.toJson()).toList();
    }
    map['test_taken'] = testTaken;
    map['average_band_score'] = averageBandScore;
    return map;
  }
}

class Content {
  Content({
    this.report,
  });

  Content.fromJson(dynamic json) {
    if (json['report'] != null) {
      report = [];
      json['report'].forEach((v) {
        report?.add(Report.fromJson(v));
      });
    }
  }

  List<Report>? report;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (report != null) {
      map['report'] = report?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Report {
  Report({
    this.category,
    this.mistake,
    this.improvement,
  });

  Report.fromJson(dynamic json) {
    category = json['category'];
    mistake = json['Mistake'];
    improvement = json['Improvement'];
  }

  String? category;
  String? mistake;
  String? improvement;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = category;
    map['Mistake'] = mistake;
    map['Improvement'] = improvement;
    return map;
  }
}

class Bands {
  Bands({
    this.listeningBand,
    this.readingBand,
    this.writingBand,
    this.speakingBand,
  });

  Bands.fromJson(dynamic json) {
    listeningBand = json['listening_band'];
    readingBand = json['reading_band'];
    writingBand = json['writing_band'];
    speakingBand = json['speaking_band'];
  }

  num? listeningBand;
  num? readingBand;
  num? writingBand;
  num? speakingBand;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['listening_band'] = listeningBand;
    map['reading_band'] = readingBand;
    map['writing_band'] = writingBand;
    map['speaking_band'] = speakingBand;
    return map;
  }
}
