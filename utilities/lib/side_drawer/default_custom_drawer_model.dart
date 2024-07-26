class DefaultCustomDrawerModel {
  DefaultCustomDrawerModel({
    this.status,
    this.result,
  });

  DefaultCustomDrawerModel.fromJson(dynamic json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  num? status;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    this.menuItems,
    this.contact,
  });

  Result.fromJson(dynamic json) {
    if (json['menuItems'] != null) {
      menuItems = [];
      json['menuItems'].forEach((v) {
        menuItems?.add(MenuItems.fromJson(v));
      });
    }
    contact = json['contact'] != null ? Contact.fromJson(json['contact']) : null;
  }
  List<MenuItems>? menuItems;
  Contact? contact;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (menuItems != null) {
      map['menuItems'] = menuItems?.map((v) => v.toJson()).toList();
    }

    if (contact != null) {
      map['contact'] = contact?.toJson();
    }
    return map;
  }
}

class Contact {
  Contact({
    this.whatsappIcon,
    this.whatsappNumber,
    this.callIcon,
    this.callNumber,
    this.mailIcon,
    this.mail,
  });

  Contact.fromJson(dynamic json) {
    whatsappIcon = json['whatsappIcon'];
    whatsappNumber = json['whatsappNumber'];
    callIcon = json['callIcon'];
    callNumber = json['callNumber'];
    mailIcon = json['mailIcon'];
    mail = json['mail'];
  }
  String? whatsappIcon;
  String? whatsappNumber;
  String? callIcon;
  String? callNumber;
  String? mailIcon;
  String? mail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['whatsappIcon'] = whatsappIcon;
    map['whatsappNumber'] = whatsappNumber;
    map['callIcon'] = callIcon;
    map['callNumber'] = callNumber;
    map['mailIcon'] = mailIcon;
    map['mail'] = mail;
    return map;
  }
}

class MenuItems {
  MenuItems({
    this.title,
    this.path,
    this.icon,
    this.url,
    this.key,
  });

  MenuItems.fromJson(dynamic json) {
    title = json['title'];
    path = json['path'];
    icon = json['icon'];
    url = json['url'];
    key = json['key'];
  }
  String? title;
  String? path;
  String? icon;
  String? url;
  String? key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['path'] = path;
    map['icon'] = icon;
    map['url'] = url;
    map['key'] = key;
    return map;
  }
}
