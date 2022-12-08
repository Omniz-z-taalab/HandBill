import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/user.dart';

class HandmadeModel {
  int? _id;
  String? _userId;
  String? _titleAr;
  String? _descriptionAr;
  String? _description;
  String? _title;
  String? _price;
  List<ImageModel>? _images;
  Userr? _user;

  int? get id => _id;
  String? get userId => _userId;
  String? get description => _description;
  String? get title => _title;
  String? get price => _price;
  String? get titleAr => _titleAr;
  String? get descriptionAr => _descriptionAr;
  Userr? get user => _user;
  List<ImageModel>? get images => _images;

  HandmadeModel({
    int? id,
    String? userId,
    String? description,
    String? title,
    String? price,
    String? createdAt,
    String? updatedAt,
    Userr? user,
    List<ImageModel>? images}){
    _id = id;
    _userId = userId;
    _description = description;
    _title = title;
    _price = price;
    _titleAr = titleAr;
    _descriptionAr = descriptionAr;
    _user = user;
    _images = images;
  }

  HandmadeModel.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _description = json["description"];
    _title = json["title"];
    _price = json["price"];
    _titleAr = json["title_ar"];
    _descriptionAr = json["description_ar"];
    _user = json['user'] != null ? new Userr.fromJson(json['user']) : null;
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images?.add(ImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["description"] = _description;
    map["title"] = _title;
    map["price"] = _price;
    map["title_ar"] = titleAr;
    map["description_ar"] = _descriptionAr;
    if (_user != null) {
      map["user"] = _user?.toJson();
    }
    if (_images != null) {
      map["images"] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set price(String ?value) {
    _price = value;
  }

  set title(String ?value) {
    _title = value;
  }

  set description(String? value) {
    _description = value;
  }
}
class Userr {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? deviceToken;
  ImageModel? image;

  Userr(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.deviceToken,
        this.image});

  Userr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    deviceToken = json['device_token'];
    image = json['image'] != null ? new ImageModel.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['device_token'] = this.deviceToken;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}