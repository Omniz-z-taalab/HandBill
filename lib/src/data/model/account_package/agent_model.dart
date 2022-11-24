import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';

class AgentModel {
  int? _id;
  String? _active;
  String? _country;
  String? _email;
  String? _flag;
  String? _name;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;

  String? get active => _active;

  String? get country => _country;

  String? get email => _email;

  String? get flag => _flag;

  String? get name => _name;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  AgentModel(
      {int? id,
      String? active,
      String? country,
      String? email,
      String? flag,
      String? name,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _active = active;
    _country = country;
    _email = email;
    _flag = flag;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  AgentModel.fromJson(dynamic json) {
    _id = json["id"];
    _active = json["active"];
    _country = json["country"];
    _email = json["email"];
    _flag =
        json["flag"] != null ? APIData.domainLink + json["flag"] : placeholder;
    _name = json["name"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["active"] = _active;
    map["country"] = _country;
    map["email"] = _email;
    map["flag"] = _flag;
    map["name"] = _name;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
