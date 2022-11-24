import 'package:hand_bill/src/data/model/category/sub_sub_category.dart';

class SubCategoryModel {
  int? _id;
  String? _name;
  List<SubSubCategoryModel>? _subSubCategory;

  int? get id => _id;
  String? get name => _name;
  List<SubSubCategoryModel>? get subSubCategory => _subSubCategory;

  SubCategoryModel(
      {int? id, String? name, List<SubSubCategoryModel>? subSubCategory}) {
    _id = id;
    _name = name;
    _subSubCategory = subSubCategory;
  }

  SubCategoryModel.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    if (json["sub_sub_category"] != null) {
      _subSubCategory = [];
      json["sub_sub_category"].forEach((v) {
        _subSubCategory?.add(SubSubCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    if (_subSubCategory != null) {
      map["sub_sub_category"] =
          _subSubCategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
