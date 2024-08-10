class StudyAbroadDashboardModel {
  StudyAbroadDashboardModel({
    this.message,
    this.status,
    this.result,
  });

  StudyAbroadDashboardModel.fromJson(dynamic json) {
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
    this.testCard,
    this.cards,
    this.path,
    this.show,
    this.applications,
    this.timeline,
    this.counsellor,
    this.courses,
  });

  Result.fromJson(dynamic json) {
    testCard = json['testCard'] != null ? TestCard.fromJson(json['testCard']) : null;
    if (json['cards'] != null) {
      cards = [];
      json['cards'].forEach((v) {
        cards?.add(Cards.fromJson(v));
      });
    }
    path = json['path'];
    show = json['show'];
    applications =
        json['applications'] != null ? Applications.fromJson(json['applications']) : null;
    counsellor = json['counsellor'] != null ? Counsellor.fromJson(json['counsellor']) : null;
    if (json['timeline'] != null) {
      timeline = [];
      json['timeline'].forEach((v) {
        timeline?.add(Timeline.fromJson(v));
      });
    }
    if (json['courses'] != null) {
      courses = [];
      json['courses'].forEach((v) {
        courses?.add(Courses.fromJson(v));
      });
    }
  }
  TestCard? testCard;
  List<Cards>? cards;
  String? path;
  bool? show;
  Applications? applications;
  Counsellor? counsellor;
  List<Timeline>? timeline;
  List<Courses>? courses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (testCard != null) {
      map['testCard'] = testCard?.toJson();
    }
    if (cards != null) {
      map['cards'] = cards?.map((v) => v.toJson()).toList();
    }
    map['path'] = path;
    map['show'] = show;
    if (applications != null) {
      map['applications'] = applications?.toJson();
    }
    if (counsellor != null) {
      map['counsellor'] = counsellor?.toJson();
    }
    if (timeline != null) {
      map['timeline'] = timeline?.map((v) => v.toJson()).toList();
    }
    if (courses != null) {
      map['courses'] = courses?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Timeline {
  Timeline({
    this.status,
    this.createdDate,
    this.name,
  });

  Timeline.fromJson(dynamic json) {
    status = json['status'];
    createdDate = json['created_date'];
    name = json['name'];
  }
  String? status;
  String? createdDate;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['created_date'] = createdDate;
    map['name'] = name;
    return map;
  }
}

class Applications {
  Applications({
    this.title,
    this.shortlist,
    this.applied,
  });

  Applications.fromJson(dynamic json) {
    title = json['title'];
    shortlist = json['shortlist'];
    applied = json['applied'];
  }
  String? title;
  num? shortlist;
  num? applied;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['shortlist'] = shortlist;
    map['applied'] = applied;
    return map;
  }
}

class Counsellor {
  Counsellor({
    this.number,
    this.name,
  });

  Counsellor.fromJson(dynamic json) {
    number = json['number'];
    name = json['name'];
  }
  String? number;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['name'] = name;
    return map;
  }
}

class Cards {
  Cards({
    this.title,
    this.description,
    this.btn,
    this.link,
  });

  Cards.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    btn = json['btn'];
    link = json['link'];
  }
  String? title;
  String? description;
  String? btn;
  String? link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['btn'] = btn;
    map['link'] = link;
    return map;
  }
}

class TestCard {
  TestCard({
    this.title,
    this.description,
    this.btn,
    this.link,
  });

  TestCard.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    btn = json['btn'];
    link = json['link'];
  }
  String? title;
  String? description;
  String? btn;
  String? link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['btn'] = btn;
    map['link'] = link;
    return map;
  }
}

class Courses {
  Courses({
    this.id,
    this.name,
    this.universityId,
    this.intakes,
    this.inrAmount,
    this.amount,
    this.durationValue,
    this.durationUnit,
    this.university,
  });

  Courses.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    universityId = json['university_id'];
    intakes = json['Intakes'];
    inrAmount = json['InrAmount'];
    amount = json['Amount'];
    durationValue = json['durationValue'];
    durationUnit = json['durationUnit'];
    university = json['university'] != null ? University.fromJson(json['university']) : null;
  }
  num? id;
  String? name;
  num? universityId;
  String? intakes;
  num? inrAmount;
  num? amount;
  num? durationValue;
  String? durationUnit;
  University? university;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['university_id'] = universityId;
    map['Intakes'] = intakes;
    map['InrAmount'] = inrAmount;
    map['Amount'] = amount;
    map['durationValue'] = durationValue;
    map['durationUnit'] = durationUnit;
    if (university != null) {
      map['university'] = university?.toJson();
    }
    return map;
  }
}

class University {
  University({
    this.id,
    this.name,
    this.countryId,
    this.countries,
  });

  University.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    countries = json['countries'] != null ? Countries.fromJson(json['countries']) : null;
  }
  num? id;
  String? name;
  num? countryId;
  Countries? countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['country_id'] = countryId;
    if (countries != null) {
      map['countries'] = countries?.toJson();
    }
    return map;
  }
}

class Countries {
  Countries({
    this.id,
    this.name,
    this.symbol,
  });

  Countries.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
  }
  num? id;
  String? name;
  String? symbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['symbol'] = symbol;
    return map;
  }
}
