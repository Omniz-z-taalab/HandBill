
class Videos {
  String? title;
  String? name;
  String? link;

  Videos({this.title, this.name, this.link});

  Videos.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    name = json['name'];
    link = json['link'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['title'] = this.title;
    data['name'] = this.name;
    data['link'] = this.link;
    return data;
  }
}
class Banners {
  int? id;
  String? modelId;
  String? description;
  String? modelType;
  String? thump;
  String? icon;
  String? url;
  String? createdAt;
  String? updatedAt;

  Banners(
      {this.id,
        this.modelId,
        this.description,
        this.modelType,
        this.thump,
        this.icon,
        this.url,
        this.createdAt,
        this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
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