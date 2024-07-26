class ApplicationManagerModel {
  ApplicationManagerModel({
    this.result,
    this.status,
    this.msg,
  });

  ApplicationManagerModel.fromJson(dynamic json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    status = json['status'];
    msg = json['msg'];
  }
  Result? result;
  num? status;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['status'] = status;
    map['msg'] = msg;
    return map;
  }
}

class Result {
  Result({
    this.shortlistedCourses,
    this.applyCourses,
  });

  Result.fromJson(dynamic json) {
    if (json['shortlistedCourses'] != null) {
      shortlistedCourses = [];
      json['shortlistedCourses'].forEach((v) {
        shortlistedCourses?.add(ShortlistedCourses.fromJson(v));
      });
    }
    if (json['applyCourses'] != null) {
      applyCourses = [];
      json['applyCourses'].forEach((v) {
        applyCourses?.add(ApplyCourses.fromJson(v));
      });
    }
  }
  List<ShortlistedCourses>? shortlistedCourses;
  List<ApplyCourses>? applyCourses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shortlistedCourses != null) {
      map['shortlistedCourses'] = shortlistedCourses?.map((v) => v.toJson()).toList();
    }
    if (applyCourses != null) {
      map['applyCourses'] = applyCourses?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ApplyCourses {
  ApplyCourses({
    this.name,
    this.card,
    this.timeline,
  });

  ApplyCourses.fromJson(dynamic json) {
    name = json['name'];
    card = json['card'] != null ? Card.fromJson(json['card']) : null;
    if (json['timeline'] != null) {
      timeline = [];
      json['timeline'].forEach((v) {
        timeline?.add(Timeline.fromJson(v));
      });
    }
  }
  String? name;
  Card? card;
  List<Timeline>? timeline;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    if (card != null) {
      map['card'] = card?.toJson();
    }
    if (timeline != null) {
      map['timeline'] = timeline?.map((v) => v.toJson()).toList();
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

class Card {
  Card({
    this.name,
    this.universityName,
    this.date,
    this.applicationId,
    this.status,
  });

  Card.fromJson(dynamic json) {
    name = json['name'];
    universityName = json['university_name'];
    date = json['date'];
    applicationId = json['application_id'];
    status = json['status'];
  }
  String? name;
  String? universityName;
  String? date;
  num? applicationId;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['university_name'] = universityName;
    map['date'] = date;
    map['application_id'] = applicationId;
    map['status'] = status;
    return map;
  }
}

class ShortlistedCourses {
  ShortlistedCourses({
    this.id,
    this.courseId,
    this.applied,
    this.course,
  });

  ShortlistedCourses.fromJson(dynamic json) {
    id = json['id'];
    courseId = json['course_id'];
    applied = json['applied'];
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
  }
  num? id;
  num? courseId;
  num? applied;
  Course? course;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['course_id'] = courseId;
    map['applied'] = applied;
    if (course != null) {
      map['course'] = course?.toJson();
    }
    return map;
  }
}

class Course {
  Course({
    this.name,
    this.id,
    this.amount,
    this.universityId,
    this.durationValue,
    this.durationUnit,
    this.url,
    this.intakes,
    this.currency,
    this.university,
  });

  Course.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
    amount = json['Amount'];
    universityId = json['university_id'];
    durationValue = json['durationValue'];
    durationUnit = json['durationUnit'];
    url = json['url'];
    intakes = json['Intakes'];
    currency = json['Currency'];
    university = json['university'] != null ? University.fromJson(json['university']) : null;
  }
  String? name;
  num? id;
  num? amount;
  num? universityId;
  num? durationValue;
  String? durationUnit;
  String? url;
  String? intakes;
  String? currency;
  University? university;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    map['Amount'] = amount;
    map['university_id'] = universityId;
    map['durationValue'] = durationValue;
    map['durationUnit'] = durationUnit;
    map['url'] = url;
    map['Intakes'] = intakes;
    map['Currency'] = currency;
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
    this.name,
    this.id,
  });

  Countries.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
  }
  String? name;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    return map;
  }
}
