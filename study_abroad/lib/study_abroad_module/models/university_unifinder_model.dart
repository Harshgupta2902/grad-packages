import 'package:flutter/cupertino.dart';

class UniversityUnifinderModel {
  UniversityUnifinderModel({
    this.status,
    this.message,
    this.result,
  });

  UniversityUnifinderModel.fromJson(dynamic json) {
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
    this.university,
    this.countryUrl,
    this.totalUniversity,
  });

  Result.fromJson(dynamic json) {
    if (json['university'] != null) {
      university = [];
      json['university'].forEach((v) {
        university?.add(University.fromJson(v));
      });
    }
    countryUrl = json['country_url'] != null ? CountryUrl.fromJson(json['country_url']) : null;
    totalUniversity = json['totalUniversity'];
  }
  List<University>? university;
  CountryUrl? countryUrl;
  num? totalUniversity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (university != null) {
      map['university'] = university?.map((v) => v.toJson()).toList();
    }
    if (countryUrl != null) {
      map['country_url'] = countryUrl?.toJson();
    }
    map['totalUniversity'] = totalUniversity;
    return map;
  }
}

class CountryUrl {
  CountryUrl({
    this.url,
    this.name,
  });

  CountryUrl.fromJson(dynamic json) {
    url = json['url'];
    name = json['name'];
  }
  String? url;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['name'] = name;
    return map;
  }
}

class University {
  University({
    this.id,
    this.name,
    this.qsRanking,
    this.url,
    this.recommended,
    this.countryId,
    this.countries,
    this.averageInrAmount,
    this.averageAmount,
    this.intakes,
    this.tests,
  });

  University.fromJson(dynamic json) {
    try {
      id = json['id'];
      name = json['name'];
      qsRanking = json['qs_ranking'];
      url = json['url'];
      recommended = json['recommended'];
      countryId = json['country_id'];
      countries = json['countries'] != null ? Countries.fromJson(json['countries']) : null;
      averageInrAmount = json['averageInrAmount'];
      averageAmount = json['averageAmount'];
      intakes = json['intakes'] != null ? json['intakes'].cast<String>() : [];

      tests = json['tests'] != null ? json['tests'].cast<String>() : [];
    } catch (e) {
      debugPrint("UniversityFinderModel: University => $e");
    }
  }
  num? id;
  String? name;
  num? qsRanking;
  String? url;
  num? recommended;
  num? countryId;
  Countries? countries;
  String? averageInrAmount;
  String? averageAmount;
  List<String>? intakes;
  List<String>? tests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['qs_ranking'] = qsRanking;
    map['url'] = url;
    map['recommended'] = recommended;
    map['country_id'] = countryId;
    if (countries != null) {
      map['countries'] = countries?.toJson();
    }
    map['averageInrAmount'] = averageInrAmount;
    map['averageAmount'] = averageAmount;
    map['intakes'] = intakes;

    map['tests'] = tests;
    return map;
  }
}

class Countries {
  Countries({
    this.id,
    this.name,
    this.url,
    this.symbol,
  });

  Countries.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    symbol = json['symbol'];
  }
  num? id;
  String? name;
  String? url;
  String? symbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['url'] = url;
    map['symbol'] = symbol;
    return map;
  }
}