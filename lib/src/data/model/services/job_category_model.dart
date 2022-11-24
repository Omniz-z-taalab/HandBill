class JobCategoryModel {
  int? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  JobCategoryModel({
    int? id,
    String? name,
    String? createdAt,
    String? updatedAt}){
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  JobCategoryModel.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}