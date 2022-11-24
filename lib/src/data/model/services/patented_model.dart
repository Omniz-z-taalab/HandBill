import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/user.dart';

class PatentedModel {
  int? _id;
  String? _userId;
  String? _description;
  String? _title;
  User? _user;
  List<ImageModel>? _image;

  int? get id => _id;

  String? get userId => _userId;

  String? get description => _description;

  String? get title => _title;

  User? get user => _user;

  List<ImageModel>? get image => _image;

  PatentedModel(
      {int? id,
      String? userId,
      String? description,
      String? title,
      String? price,
      String? createdAt,
      String? updatedAt,
      User? user,
      List<ImageModel>? image}) {
    _id = id;
    _userId = userId;
    _description = description;
    _title = title;

    _user = user;
    _image = image;
  }

  PatentedModel.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _description = json["description"];
    _title = json["title"];

    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    if (json["images"] != null) {
      _image = [];
      json["images"].forEach((v) {
        _image?.add(ImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["description"] = _description;
    map["title"] = _title;

    if (_user != null) {
      map["user"] = _user?.toJson();
    }
    if (_image != null) {
      map["images"] = _image?.map((v) => v.toJson()).toList();
    }
    return map;
  }



  set title(String? value) {
    _title = value;
  }

  set description(String? value) {
    _description = value;
  }
}
