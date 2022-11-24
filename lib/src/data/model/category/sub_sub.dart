import 'package:hand_bill/src/data/model/local/images.dart';

class SubSubCategoryModel {
  List<SubSubCategoryModelData>? data;
  bool? status;
  String? message;

  SubSubCategoryModel({this.data, this.status, this.message});

  SubSubCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubSubCategoryModelData>[];
      json['data'].forEach((v) {
        data!.add(new SubSubCategoryModelData.fromJson(v));
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

class SubSubCategoryModelData {
  int? id;
  String? name;
  ImageModel? image;

  SubSubCategoryModelData({this.id, this.name, this.image});

  SubSubCategoryModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? new ImageModel.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class Imageee {
  int? id;
  String? modelId;
  String? description;
  String? modelType;
  String? thump;
  String? icon;
  String? url;
  String? createdAt;
  String? updatedAt;

  Imageee(
      {this.id,
      this.modelId,
      this.description,
      this.modelType,
      this.thump,
      this.icon,
      this.url,
      this.createdAt,
      this.updatedAt});

  Imageee.fromJson(Map<String, dynamic> json) {
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
