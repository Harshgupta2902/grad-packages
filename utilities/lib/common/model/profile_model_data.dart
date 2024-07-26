class ProfileModelData {
  ProfileModelData({
    this.status,
    this.profile,
    this.msg,
  });

  ProfileModelData.fromJson(dynamic json) {
    status = json['status'];
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    msg = json['msg'];
  }
  num? status;
  Profile? profile;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (profile != null) {
      map['profile'] = profile?.toJson();
    }
    map['msg'] = msg;
    return map;
  }
}

class Profile {
  Profile({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.country,
    this.phone,
    this.phoneVerifiedAt,
    this.emailVerifiedAt,
    this.image,
    this.alternatePhone,
    this.passportNumber,
    this.passportExpiry,
    this.birthDate,
    this.gender,
    this.countryId,
    this.countriesName,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.imageUrl,
  });

  Profile.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    country = json['country'];
    phone = json['phone'];
    phoneVerifiedAt = json['phone_verified_at'];
    emailVerifiedAt = json['email_verified_at'];
    image = json['image'];
    alternatePhone = json['alternate_phone'];
    passportNumber = json['passport_number'];
    passportExpiry = json['passport_expiry'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    countryId = json['country_id'];
    countriesName = json['countries_name'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    imageUrl = json['image_url'];
  }
  num? id;
  String? name;
  String? lastName;
  String? email;
  String? country;
  String? phone;
  String? phoneVerifiedAt;
  dynamic emailVerifiedAt;
  String? image;
  String? alternatePhone;
  dynamic passportNumber;
  dynamic passportExpiry;
  String? birthDate;
  String? gender;
  num? countryId;
  String? countriesName;
  String? stateId;
  String? stateName;
  String? cityId;
  String? cityName;
  String? imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['last_name'] = lastName;
    map['email'] = email;
    map['country'] = country;
    map['phone'] = phone;
    map['phone_verified_at'] = phoneVerifiedAt;
    map['email_verified_at'] = emailVerifiedAt;
    map['image'] = image;
    map['alternate_phone'] = alternatePhone;
    map['passport_number'] = passportNumber;
    map['passport_expiry'] = passportExpiry;
    map['birth_date'] = birthDate;
    map['gender'] = gender;
    map['country_id'] = countryId;
    map['countries_name'] = countriesName;
    map['state_id'] = stateId;
    map['state_name'] = stateName;
    map['city_id'] = cityId;
    map['city_name'] = cityName;
    map['image_url'] = imageUrl;
    return map;
  }
}
