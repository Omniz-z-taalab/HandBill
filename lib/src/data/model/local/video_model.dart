import 'package:hand_bill/src/common/api_data.dart';

class VideoModel {
  dynamic? _id;
  dynamic? _order;
  dynamic? _modelId;
  dynamic? _description;
  dynamic? _modelType;
  dynamic? _url;
  dynamic? _createdAt;
  dynamic? _updatedAt;

  dynamic? get id => _id;

  dynamic? get order => _order;

  dynamic? get modelId => _modelId;

  dynamic? get description => _description;

  dynamic? get modelType => _modelType;

  dynamic? get url => _url;

  dynamic? get createdAt => _createdAt;

  dynamic? get updatedAt => _updatedAt;

  VideoModel(
      {int? id,
      String? order,
      String? modelId,
      String? description,
      String? modelType,
      String? url,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _order = order;
    _modelId = modelId;
    _description = description;
    _modelType = modelType;
    _url = url;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  VideoModel.fromJson(dynamic json) {
    _id = json["id"];
    _order = json["order"];
    _modelId = json["model_id"];
    _description = json["description"];
    _modelType = json["model_type"];
    _url = APIData.domainLink + json["url"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map["id"] = _id;
    map["order"] = _order;
    map["model_id"] = _modelId;
    map["description"] = _description;
    map["model_type"] = _modelType;
    map["url"] = _url;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
