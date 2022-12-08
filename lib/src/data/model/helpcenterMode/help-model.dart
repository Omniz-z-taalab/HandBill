import 'package:hand_bill/src/data/model/Search_data.dart';
class IconMail {
  int? id;
  String? modelId;
  String? description;
  String? modelType;
  dynamic? thump;
  String? icon;
  String? url;
  String? createdAt;
  String? updatedAt;

  IconMail(
      {this.id,
        this.modelId,
        this.description,
        this.modelType,
        this.thump,
        this.icon,
        this.url,
        this.createdAt,
        this.updatedAt});

  IconMail.fromJson(Map<String, dynamic> json) {
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
class HelpCenterModel {
  int? id;
  String? email;
  String? createdAt;
  String? updatedAt;
  IconMail? icon;

  HelpCenterModel({this.id, this.email, this.createdAt, this.updatedAt, this.icon});

  HelpCenterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon = json['icon'] != null ? new IconMail.fromJson(json['icon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.icon != null) {
      data['icon'] = this.icon!.toJson();
    }    return data;
  }
}