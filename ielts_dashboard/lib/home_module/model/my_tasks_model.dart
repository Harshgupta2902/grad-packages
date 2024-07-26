class MyTasksModel {
  MyTasksModel({
    this.status,
    this.msg,
    this.result,});

  MyTasksModel.fromJson(dynamic json) {
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
    this.today,
    this.missed,});

  Result.fromJson(dynamic json) {
    if (json['today'] != null) {
      today = [];
      json['today'].forEach((v) {
        today?.add(Today.fromJson(v));
      });
    }
    if (json['missed'] != null) {
      missed = [];
      json['missed'].forEach((v) {
        missed?.add(Missed.fromJson(v));
      });
    }
  }
  List<Today>? today;
  List<Missed>? missed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (today != null) {
      map['today'] = today?.map((v) => v.toJson()).toList();
    }
    if (missed != null) {
      map['missed'] = missed?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Missed {
  Missed({
    this.taskName,
    this.taskType,
    this.taskModule,
    this.taskDuration,
    this.mockTest,
    this.mockTestType,
    this.classId,
    this.assignDate,
    this.submitDate,});

  Missed.fromJson(dynamic json) {
    taskName = json['task_name'];
    taskType = json['task_type'];
    taskModule = json['task_module'];
    taskDuration = json['task_duration'];
    mockTest = json['mock_test'];
    mockTestType = json['mock_test_type'];
    classId = json['class_id'];
    assignDate = json['assign_date'];
    submitDate = json['submit_date'];
  }
  String? taskName;
  String? taskType;
  String? taskModule;
  dynamic taskDuration;
  dynamic mockTest;
  dynamic mockTestType;
  num? classId;
  String? assignDate;
  dynamic submitDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['task_name'] = taskName;
    map['task_type'] = taskType;
    map['task_module'] = taskModule;
    map['task_duration'] = taskDuration;
    map['mock_test'] = mockTest;
    map['mock_test_type'] = mockTestType;
    map['class_id'] = classId;
    map['assign_date'] = assignDate;
    map['submit_date'] = submitDate;
    return map;
  }

}

class Today {
  Today({
    this.taskName,
    this.taskType,
    this.taskModule,
    this.taskDuration,
    this.mockTest,
    this.mockTestType,
    this.classId,
    this.assignDate,
    this.submitDate,});

  Today.fromJson(dynamic json) {
    taskName = json['task_name'];
    taskType = json['task_type'];
    taskModule = json['task_module'];
    taskDuration = json['task_duration'];
    mockTest = json['mock_test'];
    mockTestType = json['mock_test_type'];
    classId = json['class_id'];
    assignDate = json['assign_date'];
    submitDate = json['submit_date'];
  }
  String? taskName;
  String? taskType;
  String? taskModule;
  dynamic taskDuration;
  dynamic mockTest;
  dynamic mockTestType;
  num? classId;
  String? assignDate;
  dynamic submitDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['task_name'] = taskName;
    map['task_type'] = taskType;
    map['task_module'] = taskModule;
    map['task_duration'] = taskDuration;
    map['mock_test'] = mockTest;
    map['mock_test_type'] = mockTestType;
    map['class_id'] = classId;
    map['assign_date'] = assignDate;
    map['submit_date'] = submitDate;
    return map;
  }

}