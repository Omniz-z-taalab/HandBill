import '../../model/Search_data.dart';

class SearchCategoriesResponse {
  List<SubCategorySearch>? data;
  bool? status;
  String? message;

  SearchCategoriesResponse({this.data, this.status, this.message});

  SearchCategoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubCategorySearch>[];
      json['data'].forEach((v) {
        data!.add(new SubCategorySearch.fromJson(v));
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

class SubCategorySearch {
  int? id;
  String? name;
  String? icon;

  SubCategorySearch({this.id, this.name, this.icon});

  SubCategorySearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.icon != null) {
      data['icon'] = this.icon!;
    }
    return data;
  }
}

class Iconn {
  dynamic? id;
  dynamic? modelId;
  dynamic? description;
  dynamic? modelType;
  dynamic? thump;
  dynamic? icon;
  dynamic? url;
  dynamic? createdAt;
  dynamic? updatedAt;

  Iconn(
      {this.id,
        this.modelId,
        this.description,
        this.modelType,
        this.thump,
        this.icon,
        this.url,
        this.createdAt,
        this.updatedAt});

  Iconn.fromJson(Map<String, dynamic> json) {
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

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<String, dynamic>();
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