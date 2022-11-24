import 'package:hand_bill/src/data/model/local/images.dart';

class SubCategoryModel {
  List<SubCategoryModelData>? data;
  bool? status;
  String? message;

  SubCategoryModel({this.data, this.status, this.message});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubCategoryModelData>[];
      json['data'].forEach((v) {
        data!.add(new SubCategoryModelData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class SubCategoryModelData {
  int? id;
  String? name;
  Icon? icon;

  SubCategoryModelData({this.id, this.name, this.icon});

  SubCategoryModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'] != null ? new Icon.fromJson(json['icon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.icon != null) {
      data['icon'] = this.icon!.toJson();
    }
    return data;
  }
}
class Icon {
  int? id;
  String? modelId;
  String? description;
  String? modelType;
  String? thump;
  String? icon;
  String? url;
  String? createdAt;
  String? updatedAt;

  Icon(
      {this.id,
        this.modelId,
        this.description,
        this.modelType,
        this.thump,
        this.icon,
        this.url,
        this.createdAt,
        this.updatedAt});

  Icon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['model_id'];
    description = json['description'];
    modelType = json['model_type'];
    thump = json['thump'];
    icon = json['icon'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_id'] = this.modelId;
    data['description'] = this.description;
    data['model_type'] = this.modelType;
    data['thump'] = this.thump;
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
