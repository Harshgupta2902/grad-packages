class DashboardDataModel {
  DashboardDataModel({
      this.status, 
      this.result, 
      this.msg,});

  DashboardDataModel.fromJson(dynamic json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    msg = json['msg'];
  }
  num? status;
  Result? result;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['msg'] = msg;
    return map;
  }

}

class Result {
  Result({
      this.stripData, 
      this.cards, 
      this.courseProgress,});

  Result.fromJson(dynamic json) {
    stripData = json['stripData'] != null ? StripData.fromJson(json['stripData']) : null;
    if (json['cards'] != null) {
      cards = [];
      json['cards'].forEach((v) {
        cards?.add(Cards.fromJson(v));
      });
    }
    courseProgress = json['courseProgress'];
  }
  StripData? stripData;
  List<Cards>? cards;
  num? courseProgress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (stripData != null) {
      map['stripData'] = stripData?.toJson();
    }
    if (cards != null) {
      map['cards'] = cards?.map((v) => v.toJson()).toList();
    }
    map['courseProgress'] = courseProgress;
    return map;
  }

}

class Cards {
  Cards({
      this.status, 
      this.title, 
      this.path, 
      this.url, 
      this.key,});

  Cards.fromJson(dynamic json) {
    status = json['status'];
    title = json['title'];
    path = json['path'];
    url = json['url'];
    key = json['key'];
  }
  bool? status;
  String? title;
  String? path;
  String? url;
  String? key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['title'] = title;
    map['path'] = path;
    map['url'] = url;
    map['key'] = key;
    return map;
  }

}

class StripData {
  StripData({
      this.welcomeStripTitle, 
      this.welcomeStripDesc, 
      this.classScheduleText, 
      this.classButtonText, 
      this.classButtonLink, 
      this.classEndLink, 
      this.classLinkError, 
      this.classStatus, 
      this.classId,});

  StripData.fromJson(dynamic json) {
    welcomeStripTitle = json['welcomeStripTitle'];
    welcomeStripDesc = json['welcomeStripDesc'];
    classScheduleText = json['classScheduleText'];
    classButtonText = json['classButtonText'];
    classButtonLink = json['classButtonLink'];
    classEndLink = json['classEndLink'];
    classLinkError = json['classLinkError'];
    classStatus = json['classStatus'];
    classId = json['class_id'];
  }
  String? welcomeStripTitle;
  String? welcomeStripDesc;
  String? classScheduleText;
  String? classButtonText;
  String? classButtonLink;
  String? classEndLink;
  String? classLinkError;
  bool? classStatus;
  dynamic classId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['welcomeStripTitle'] = welcomeStripTitle;
    map['welcomeStripDesc'] = welcomeStripDesc;
    map['classScheduleText'] = classScheduleText;
    map['classButtonText'] = classButtonText;
    map['classButtonLink'] = classButtonLink;
    map['classEndLink'] = classEndLink;
    map['classLinkError'] = classLinkError;
    map['classStatus'] = classStatus;
    map['class_id'] = classId;
    return map;
  }

}