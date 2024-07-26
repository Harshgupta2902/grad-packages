class FilterDataModel {
  FilterDataModel({
    this.status,
    this.message,
    this.result,
  });

  FilterDataModel.fromJson(dynamic json) {
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
    this.filters,
    this.selected,
  });

  Result.fromJson(dynamic json) {
    if (json['Filters'] != null) {
      filters = [];
      json['Filters'].forEach((v) {
        filters?.add(Filters.fromJson(v));
      });
    }
    if (json['Selected'] != null) {
      selected = {};
      json['Selected'].forEach((k, v) {
        selected![k] = List<String>.from(v);
      });
    }
  }
  List<Filters>? filters;
  Map<String, List<String>>? selected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (filters != null) {
      map['Filters'] = filters?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Selected {
  Selected({
    this.currency,
  });

  Selected.fromJson(dynamic json) {
    currency = json['Currency'] != null ? json['Currency'].cast<String>() : [];
  }
  List<String>? currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Currency'] = currency;
    return map;
  }
}

class Filters {
  Filters({
    this.filterName,
    this.filterKey,
    this.options,
    this.type,
  });

  Filters.fromJson(dynamic json) {
    filterName = json['filterName'];
    filterKey = json['filterKey'];
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
    type = json['type'];
  }
  String? filterName;
  String? filterKey;
  List<Options>? options;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['filterName'] = filterName;
    map['filterKey'] = filterKey;
    if (options != null) {
      map['options'] = options?.map((v) => v.toJson()).toList();
    }
    map['type'] = type;
    return map;
  }
}

class Options {
  Options({
    this.label,
    this.value,
  });

  Options.fromJson(dynamic json) {
    label = json['label'];
    value = json['value'].toString();
  }
  String? label;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    return map;
  }
}