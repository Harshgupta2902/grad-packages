import 'package:flutter/material.dart';

class CoursesUnifinderModel {
  CoursesUnifinderModel({
    this.message,
    this.status,
    this.result,
  });

  CoursesUnifinderModel.fromJson(dynamic json) {
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
    this.courses,
    this.totalCourses,
    this.safeCount,
    this.moderateCount,
    this.lowCount,
    this.safeCourses,
    this.moderateCourses,
    this.lowCourses,
  });

  Result.fromJson(dynamic json) {
    try {
      if (json['courses'] != null) {
        courses = [];
        json['courses'].forEach((v) {
          courses?.add(Courses.fromJson(v));
        });
      }
      totalCourses = json['totalCourses'];
      safeCount = json['safeCount'];
      moderateCount = json['moderateCount'];
      lowCount = json['lowCount'];
      if (json['safeCourses'] != null) {
        safeCourses = [];
        json['safeCourses'].forEach((v) {
          safeCourses?.add(SafeCourses.fromJson(v));
        });
      }
      if (json['moderateCourses'] != null) {
        moderateCourses = [];
        json['moderateCourses'].forEach((v) {
          moderateCourses?.add(SafeCourses.fromJson(v));
        });
      }
      if (json['lowCourses'] != null) {
        lowCourses = [];
        json['lowCourses'].forEach((v) {
          lowCourses?.add(SafeCourses.fromJson(v));
        });
      }
    } catch (e) {
      debugPrint("Result ::::::::: Result=> main resault $e");
    }
  }
  List<Courses>? courses;
  num? totalCourses;

  num? safeCount;
  num? moderateCount;
  num? lowCount;
  List<SafeCourses>? safeCourses;
  List<SafeCourses>? moderateCourses;
  List<SafeCourses>? lowCourses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (courses != null) {
      map['courses'] = courses?.map((v) => v.toJson()).toList();
    }
    map['totalCourses'] = totalCourses;
    map['safeCount'] = safeCount;
    map['moderateCount'] = moderateCount;
    map['lowCount'] = lowCount;
    if (safeCourses != null) {
      map['safeCourses'] = safeCourses?.map((v) => v.toJson()).toList();
    }
    if (moderateCourses != null) {
      map['moderateCourses'] = moderateCourses?.map((v) => v.toJson()).toList();
    }
    if (lowCourses != null) {
      map['lowCourses'] = lowCourses?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SafeCourses {
  SafeCourses({
    this.id,
    this.name,
    this.universityId,
    this.intakes,
    this.inrAmount,
    this.amount,
    this.durationValue,
    this.durationUnit,
    this.shortlisted,
    this.university,
  });

  SafeCourses.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    universityId = json['university_id'];
    intakes = json['Intakes'];
    inrAmount = json['InrAmount'];
    amount = json['Amount'];
    durationValue = json['durationValue'];
    durationUnit = json['durationUnit'];
    shortlisted = json['shortlisted'];
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
  bool? shortlisted;
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
    map['shortlisted'] = shortlisted;
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
    this.shortlisted,
    this.applied,
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
    shortlisted = json['shortlisted'];
    applied = json['applied'];
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
  bool? shortlisted;
  bool? applied;
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
    map['shortlisted'] = shortlisted;
    map['applied'] = applied;
    map['durationUnit'] = durationUnit;
    if (university != null) {
      map['university'] = university?.toJson();
    }
    return map;
  }
}
