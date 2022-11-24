class ExploreModel {
  int? _id;
  String? _link;
  String? _title;
  String? _body;
  DateTime? _dateTime;

  int? get id => _id;

  String? get link => _link;

  set setLink(val) => _link = val;

  String? get title => _title;

  String? get body => _body;

  DateTime? get dateTime => _dateTime;


  ExploreModel(
      {int? id,
        String? link,
        String? title,
        String? updatedAt}) {
    _id = id;
    _link = link;
    _title = title;
    _body = body;
    _dateTime = dateTime;
  }

  ExploreModel.fromJson(dynamic json) {
    _id = json["id"];
    _link = json["link"];
    _title = json["title"];
    _body = json["body"];
    _dateTime = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["link"] = _link;
    map["title"] = _title;
    map["body"] = _body;
    map["dateTime"] = _dateTime;
    return map;
  }
}
