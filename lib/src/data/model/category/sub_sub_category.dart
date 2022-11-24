import 'package:hand_bill/src/data/model/local/images.dart';

class SubSubCategoryModel {
  int? _id;
  String? _subCategoryId;
  String? _categoryId;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
  ImageModel? _image;

  int? get id => _id;
  String? get subCategoryId => _subCategoryId;
  String? get categoryId => _categoryId;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  ImageModel? get image => _image;

  SubSubCategoryModel({
    int? id,
    String? subCategoryId,
    String? categoryId,
    String? name,
    String? createdAt,
    String? updatedAt,
    ImageModel? image}){
    _id = id;
    _subCategoryId = subCategoryId;
    _categoryId = categoryId;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _image = image;
  }

  SubSubCategoryModel.fromJson(dynamic json) {
    _id = json["id"];
    _subCategoryId = json["sub_category_id"];
    _categoryId = json["category_id"];
    _name = json["name"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _image = json["image"] != null ? ImageModel.fromJson(json["image"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["sub_category_id"] = _subCategoryId;
    map["category_id"] = _categoryId;
    map["name"] = _name;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_image != null) {
      map["image"] = _image?.toJson();
    }
    return map;
  }

}