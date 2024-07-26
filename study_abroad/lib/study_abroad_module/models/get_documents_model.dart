class GetDocumentsModel {
  GetDocumentsModel({
    this.status,
    this.result,
  });

  GetDocumentsModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }
  num? status;
  List<Result>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Result {
  Result({
    this.title,
    this.description,
    this.documents,
  });

  Result.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    if (json['documents'] != null) {
      documents = [];
      json['documents'].forEach((v) {
        documents?.add(Documents.fromJson(v));
      });
    }
  }
  String? title;
  String? description;
  List<Documents>? documents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    if (documents != null) {
      map['documents'] = documents?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Documents {
  Documents({
    this.name,
    this.status,
    this.id,
    this.link,
  });

  Documents.fromJson(dynamic json) {
    name = json['name'];
    status = json['status'];
    id = json['id'];
    link = json['link'];
  }
  String? name;
  String? status;
  num? id;
  String? link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['status'] = status;
    map['id'] = id;
    map['link'] = link;
    return map;
  }
}
