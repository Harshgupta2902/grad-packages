class GuestDashboardModel {
  GuestDashboardModel({
    this.status,
    this.msg,
    this.result,
  });

  GuestDashboardModel.fromJson(dynamic json) {
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
    this.services,
    this.batch,
    this.cards,
    this.banner,
    this.testTypeAvailable,
  });

  Result.fromJson(dynamic json) {
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services?.add(Services.fromJson(v));
      });
    }
    batch = json['batch'] != null ? Batch.fromJson(json['batch']) : null;
    if (json['cards'] != null) {
      cards = [];
      json['cards'].forEach((v) {
        cards?.add(Cards.fromJson(v));
      });
    }
    banner = json['banner'] != null ? Banner.fromJson(json['banner']) : null;
    testTypeAvailable = json['testTypeAvailable'];
  }

  List<Services>? services;
  Batch? batch;
  List<Cards>? cards;
  Banner? banner;
  bool? testTypeAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    if (batch != null) {
      map['batch'] = batch?.toJson();
    }
    if (cards != null) {
      map['cards'] = cards?.map((v) => v.toJson()).toList();
    }
    if (banner != null) {
      map['banner'] = banner?.toJson();
    }
    map['testTypeAvailable'] = testTypeAvailable;

    return map;
  }
}

class Banner {
  Banner({
    this.title,
    this.desc,
    this.video,
  });

  Banner.fromJson(dynamic json) {
    title = json['title'];
    desc = json['desc'];
    video = json['video'];
  }

  String? title;
  String? desc;
  String? video;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['desc'] = desc;
    map['video'] = video;
    return map;
  }
}

class Cards {
  Cards({
    this.title,
    this.path,
    this.url,
    this.key,
  });

  Cards.fromJson(dynamic json) {
    title = json['title'];
    path = json['path'];
    url = json['url'];
    key = json['key'];
  }

  String? title;
  String? path;
  String? url;
  String? key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['path'] = path;
    map['url'] = url;
    map['key'] = key;
    return map;
  }
}

class Batch {
  Batch({
    this.title,
    this.desc,
    this.booked,
  });

  Batch.fromJson(dynamic json) {
    title = json['title'];
    desc = json['desc'];
    booked = json['booked'];
  }

  String? title;
  String? desc;
  num? booked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['desc'] = desc;
    map['booked'] = booked;
    return map;
  }
}

class Services {
  Services({
    this.name,
    this.image,
  });

  Services.fromJson(dynamic json) {
    name = json['name'];
    image = json['image'];
  }

  String? name;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['image'] = image;
    return map;
  }
}
