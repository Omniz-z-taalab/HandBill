import 'package:hand_bill/src/data/model/user.dart';

class GetProfileDataModel {
  bool? status;
  User? data;
  String? message;

  GetProfileDataModel({this.status, this.data, this.message});

  GetProfileDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? isVerified;
  String? deviceToken;
  String? country;
  Null? nameAr;
  String? active;
  String? apiToken;
  String? address;
  String? email;
  String? name;
  String? phone;
  Null? image;

  Data(
      {this.id,
        this.isVerified,
        this.deviceToken,
        this.country,
        this.nameAr,
        this.active,
        this.apiToken,
        this.address,
        this.email,
        this.name,
        this.phone,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isVerified = json['is_verified'];
    deviceToken = json['device_token'];
    country = json['country'];
    nameAr = json['name_ar'];
    active = json['active'];
    apiToken = json['api_token'];
    address = json['address'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_verified'] = this.isVerified;
    data['device_token'] = this.deviceToken;
    data['country'] = this.country;
    data['name_ar'] = this.nameAr;
    data['active'] = this.active;
    data['api_token'] = this.apiToken;
    data['address'] = this.address;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['image'] = this.image;
    return data;
  }
}