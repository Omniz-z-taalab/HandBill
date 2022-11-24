class NotificationModel {
  int? _id;
  String? _productId;
  String? _title;
  String? _body;
  DateTime? _dateTime;
  String? _updatedAt;
  String? _subSubCategoryId;

  int? get id => _id;

  String? get productId => _productId;

  String? get title => _title;

  String? get body => _body;

  DateTime? get dateTime => _dateTime;

  String? get updatedAt => _updatedAt;

  String? get subSubCategoryId => _subSubCategoryId;

  NotificationModel(
      {int? id,
      String? productId,
      String? title,
      String? body,
      DateTime? dateTime,
      String? subSubCategoryId,
      String? updatedAt}) {
    _id = id;
    _subSubCategoryId = subSubCategoryId;
    _productId = productId;
    _title = title;
    _body = body;
    _dateTime = dateTime;
    _updatedAt = updatedAt;
  }

  NotificationModel.fromJson(dynamic json) {
    _id = json["id"];
    _productId = json["product_id"];
    _title = json["title"];
    _body = json["body"];
    _subSubCategoryId = json["sub_sub_category_id"];
    _dateTime = DateTime.parse(json['created_at']);
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["product_id"] = _productId;
    map["title"] = _title;
    map["body"] = _body;
    map["sub_sub_category_id"] = _subSubCategoryId;
    map["created_at"] = _dateTime;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
