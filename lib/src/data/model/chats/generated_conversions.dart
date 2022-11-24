class GeneratedConversions {
  bool? _thumb;
  bool? _icon;

  bool? get thumb => _thumb;

  bool? get icon => _icon;

  GeneratedConversions({bool? thumb, bool? icon}) {
    _thumb = thumb;
    _icon = icon;
  }

  GeneratedConversions.fromJson(dynamic json) {
    _thumb = json["thumb"];
    _icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["thumb"] = _thumb;
    map["icon"] = _icon;
    return map;
  }
}