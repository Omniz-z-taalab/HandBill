import 'package:hand_bill/src/data/model/category/sub_category.dart';

class CategoryModel {
  List<SubCategoryModel>? subCategoryModel;
  set setSubCategories(List<SubCategoryModel>? value) {
    subCategoryModel = value;
  }

  get subCategories => subCategoryModel;

  int? _id;
  String? _name;
  String? _icon;
  bool? _selected;
  int? get id => _id;

  String? get name => _name;
  String? get icon => _icon;
  bool? get selected => _selected;

  CategoryModel({int? id, String? name, bool? selected, String? icon}) {
    _id = id;
    _name = name;
    _selected = selected;
    _icon = icon;
  }

  CategoryModel.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _icon = json["icon"];

    _selected = false;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["icon"] = _icon;

    return map;
  }

  set selected(bool? value) {
    _selected = value;
  }
}
