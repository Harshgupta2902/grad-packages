class BuyPlansModel {
  BuyPlansModel({
    this.result,
    this.status,
    this.message,
  });

  BuyPlansModel.fromJson(dynamic json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    status = json['status'];
    message = json['message'];
  }
  Result? result;
  num? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['status'] = status;
    map['message'] = message;
    return map;
  }
}

class Result {
  Result({
    this.classes,
    this.mockTestPlans,
  });

  Result.fromJson(dynamic json) {
    if (json['classes'] != null) {
      classes = [];
      json['classes'].forEach((v) {
        classes?.add(Classes.fromJson(v));
      });
    }
    if (json['mockTestPlans'] != null) {
      mockTestPlans = [];
      json['mockTestPlans'].forEach((v) {
        mockTestPlans?.add(MockTestPlans.fromJson(v));
      });
    }
  }
  List<Classes>? classes;
  List<MockTestPlans>? mockTestPlans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (classes != null) {
      map['classes'] = classes?.map((v) => v.toJson()).toList();
    }
    if (mockTestPlans != null) {
      map['mockTestPlans'] = mockTestPlans?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MockTestPlans {
  MockTestPlans({
    this.id,
    this.code,
    this.name,
    this.discount,
    this.price,
    this.offerPrice,
    this.features,
    this.recommended,
  });

  MockTestPlans.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    discount = json['discount'];
    price = json['price'];
    offerPrice = json['offer_price'];
    if (json['features'] != null) {
      features = [];
      json['features'].forEach((v) {
        features?.add(Features.fromJson(v));
      });
    }
    recommended = json['recommended'];
  }
  num? id;
  String? code;
  String? name;
  String? discount;
  num? price;
  num? offerPrice;
  List<Features>? features;
  num? recommended;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['discount'] = discount;
    map['price'] = price;
    map['offer_price'] = offerPrice;
    if (features != null) {
      map['features'] = features?.map((v) => v.toJson()).toList();
    }
    map['recommended'] = recommended;
    return map;
  }
}

class Features {
  Features({
    this.keyName,
    this.value,
    this.customValue,
  });

  Features.fromJson(dynamic json) {
    keyName = json['key_name'];
    value = json['value'];
    customValue = json['custom_value'];
  }
  String? keyName;
  String? value;
  String? customValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key_name'] = keyName;
    map['value'] = value;
    map['custom_value'] = customValue;
    return map;
  }
}

class Classes {
  Classes({
    this.id,
    this.code,
    this.name,
    this.discount,
    this.price,
    this.offerPrice,
    this.features,
    this.recommended,
  });

  Classes.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    discount = json['discount'];
    price = json['price'];
    offerPrice = json['offer_price'];
    if (json['features'] != null) {
      features = [];
      json['features'].forEach((v) {
        features?.add(Features.fromJson(v));
      });
    }
    recommended = json['recommended'];
  }
  num? id;
  String? code;
  String? name;
  String? discount;
  num? price;
  num? offerPrice;
  List<Features>? features;
  num? recommended;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['discount'] = discount;
    map['price'] = price;
    map['offer_price'] = offerPrice;
    if (features != null) {
      map['features'] = features?.map((v) => v.toJson()).toList();
    }
    map['recommended'] = recommended;
    return map;
  }
}
