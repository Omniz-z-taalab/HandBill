class AboutResponse {
  AboutResponse({
    List<Videos>? videos,
    List<Banners>? banners,
    dynamic pdf,
  }) {
    _videos = videos;
    _banners = banners;
    _pdf = pdf;
  }

  AboutResponse.fromJson(dynamic json) {
    if (json['videos'] != null) {
      _videos = [];
      json['videos'].forEach((v) {
        _videos?.add(Videos.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      _banners = [];
      json['banners'].forEach((v) {
        _banners?.add(Banners.fromJson(v));
      });
    }
    _pdf = json['pdf'];
  }

  List<Videos>? _videos;
  List<Banners>? _banners;
  dynamic _pdf;

  AboutResponse copyWith({
    List<Videos>? videos,
    List<Banners>? banners,
    dynamic pdf,
  }) =>
      AboutResponse(
        videos: videos ?? _videos,
        banners: banners ?? _banners,
        pdf: pdf ?? _pdf,
      );

  List<Videos>? get videos => _videos;

  List<Banners>? get banners => _banners;

  dynamic get pdf => _pdf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_videos != null) {
      map['videos'] = _videos?.map((v) => v.toJson()).toList();
    }
    if (_banners != null) {
      map['banners'] = _banners?.map((v) => v.toJson()).toList();
    }
    map['pdf'] = _pdf;
    return map;
  }
}

class Banners {
  Banners({
    num? id,
    String? modelId,
    String? description,
    String? modelType,
    String? thump,
    String? icon,
    String? url,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _modelId = modelId;
    _description = description;
    _modelType = modelType;
    _thump = thump;
    _icon = icon;
    _url = url;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Banners.fromJson(dynamic json) {
    _id = json['id'];
    _modelId = json['model_id'];
    _description = json['description'];
    _modelType = json['model_type'];
    _thump = json['thump'];
    _icon = json['icon'];
    _url = json['url'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  String? _modelId;
  String? _description;
  String? _modelType;
  String? _thump;
  String? _icon;
  String? _url;
  String? _createdAt;
  String? _updatedAt;

  Banners copyWith({
    num? id,
    String? modelId,
    String? description,
    String? modelType,
    String? thump,
    String? icon,
    String? url,
    String? createdAt,
    String? updatedAt,
  }) =>
      Banners(
        id: id ?? _id,
        modelId: modelId ?? _modelId,
        description: description ?? _description,
        modelType: modelType ?? _modelType,
        thump: thump ?? _thump,
        icon: icon ?? _icon,
        url: url ?? _url,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  String? get modelId => _modelId;

  String? get description => _description;

  String? get modelType => _modelType;

  String? get thump => _thump;

  String? get icon => _icon;

  String? get url => _url;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['model_id'] = _modelId;
    map['description'] = _description;
    map['model_type'] = _modelType;
    map['thump'] = _thump;
    map['icon'] = _icon;
    map['url'] = _url;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Videos {
  Videos({
    String? title,
    String? name,
    String? link,
  }) {
    _title = title;
    _name = name;
    _link = link;
  }

  Videos.fromJson(dynamic json) {
    _title = json['title'];
    _name = json['name'];
    _link = json['link'];
  }

  String? _title;
  String? _name;
  String? _link;

  Videos copyWith({
    String? title,
    String? name,
    String? link,
  }) =>
      Videos(
        title: title ?? _title,
        name: name ?? _name,
        link: link ?? _link,
      );

  String? get title => _title;

  String? get name => _name;

  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['name'] = _name;
    map['link'] = _link;
    return map;
  }
}
