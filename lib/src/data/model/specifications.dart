class Specifications {
  int? _id;
  String? _productId;
  String? _value;
  String? _key;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get productId => _productId;
  String? get value => _value;
  String? get key => _key;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Specifications({
    int? id,
    String? productId,
    String? value,
    String? key,
    String? createdAt,
    String? updatedAt}){
    _id = id;
    _productId = productId;
    _value = value;
    _key = key;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Specifications.fromJson(dynamic json) {
    _id = json["id"];
    _productId = json["product_id"];
    _value = json["value"];
    _key = json["key"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["product_id"] = _productId;
    map["value"] = _value;
    map["key"] = _key;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}