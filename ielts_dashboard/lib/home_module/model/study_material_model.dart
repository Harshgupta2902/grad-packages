class StudyMaterialModel {
  StudyMaterialModel({
      this.status, 
      this.studyMaterials, 
      this.msg,});

  StudyMaterialModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['studyMaterials'] != null) {
      studyMaterials = [];
      json['studyMaterials'].forEach((v) {
        studyMaterials?.add(StudyMaterials.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<StudyMaterials>? studyMaterials;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (studyMaterials != null) {
      map['studyMaterials'] = studyMaterials?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class StudyMaterials {
  StudyMaterials({
      this.fileName, 
      this.filePath, 
      this.day, 
      this.name,});

  StudyMaterials.fromJson(dynamic json) {
    fileName = json['file_name'];
    filePath = json['file_path'];
    day = json['day'];
    name = json['name'];
  }
  String? fileName;
  String? filePath;
  num? day;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['file_name'] = fileName;
    map['file_path'] = filePath;
    map['day'] = day;
    map['name'] = name;
    return map;
  }

}