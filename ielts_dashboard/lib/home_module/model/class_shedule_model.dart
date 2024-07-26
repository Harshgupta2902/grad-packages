import 'package:flutter/material.dart';

class ClassScheduleModel {
  ClassScheduleModel({
    this.status,
    this.message,
    this.result,
  });

  ClassScheduleModel.fromJson(dynamic json) {
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
    this.dates,
    this.classData,
    this.batch,
  });

  Result.fromJson(dynamic json) {
    dates = json['dates'] != null ? json['dates'].cast<String>() : [];
    json['classData'] != null
        ? List<List<ClassData>>.from(json['classData'].map((x) {
            debugPrint("$x");
            return List<ClassData>.from(
              x.map(
                (classJson) => ClassData.fromJson(classJson),
              ),
            );
          }))
        : [];

    if (json['classData'] != null) {
      classData = [];
      json['classData'].forEach((v) {
        List<ClassData> temp = [];
        v.forEach((v) {
          temp.add(ClassData.fromJson(v));
        });
        classData?.add(temp);
      });
    }

    batch = json['batch'] != null ? Batch.fromJson(json['batch']) : null;
  }

  List<String>? dates;
  List<List<ClassData>>? classData;
  Batch? batch;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dates'] = dates;
    if (classData != null) {
      map['classData'] = classData?.map((v) => v).toList();
    }
    if (batch != null) {
      map['batch'] = batch?.toJson();
    }
    return map;
  }
}

class Batch {
  Batch({
    this.id,
    this.batchCode,
    this.batchName,
  });

  Batch.fromJson(dynamic json) {
    id = json['id'];
    batchCode = json['batch_code'];
    batchName = json['batch_name'];
  }

  num? id;
  String? batchCode;
  String? batchName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['batch_code'] = batchCode;
    map['batch_name'] = batchName;
    return map;
  }
}

class ClassData {
  ClassData({
    this.id,
    this.className,
    this.startDate,
    this.classDuration,
    this.classMode,
    this.classCode,
    this.day,
    this.moduleName,
  });

  ClassData.fromJson(dynamic json) {
    id = json['id'];
    className = json['class_name'];
    startDate = json['start_date'];
    classDuration = json['class_duration'];
    classMode = json['class_mode'];
    classCode = json['class_code'];
    day = json['day'];
    moduleName = json['module_name'];
  }

  num? id;
  String? className;
  String? startDate;
  num? classDuration;
  num? classMode;
  String? classCode;
  num? day;
  String? moduleName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['class_name'] = className;
    map['start_date'] = startDate;
    map['class_duration'] = classDuration;
    map['class_mode'] = classMode;
    map['class_code'] = classCode;
    map['day'] = day;
    map['module_name'] = moduleName;
    return map;
  }
}
