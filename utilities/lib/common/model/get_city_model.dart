class GetCityModel {
  GetCityModel({
      this.status, 
      this.message, 
      this.answers,});

  GetCityModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        answers?.add(Answers.fromJson(v));
      });
    }
  }
  num? status;
  String? message;
  List<Answers>? answers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (answers != null) {
      map['answers'] = answers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Answers {
  Answers({
      this.key, 
      this.value,});

  Answers.fromJson(dynamic json) {
    key = json['key'];
    value = json['value'];
  }
  num? key;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['value'] = value;
    return map;
  }

}