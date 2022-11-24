class HelpCenterModel {
  int? id;
  String? email;
  String? createdAt;
  String? updatedAt;
  dynamic? icon;

  HelpCenterModel({this.id, this.email, this.createdAt, this.updatedAt, this.icon});

  HelpCenterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['icon'] = this.icon;
    return data;
  }
}