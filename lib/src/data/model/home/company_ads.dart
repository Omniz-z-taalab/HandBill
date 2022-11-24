import 'package:hand_bill/src/data/model/company.dart';

class CompanyAds {
  int? _id;
  String? _status;
  String? _type;
  dynamic? _expirationDate;
  String? _companyId;
  String? _modelId;
  String? _createdAt;
  String? _updatedAt;
  Company? _company;

  int? get id => _id;
  String? get status => _status;
  String? get type => _type;
  dynamic? get expirationDate => _expirationDate;
  String? get companyId => _companyId;
  String? get modelId => _modelId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Company? get company => _company;

  CompanyAds({
    int? id,
    String? status,
    String? type,
    dynamic? expirationDate,
    String? companyId,
    String? modelId,
    String? createdAt,
    String? updatedAt,
    Company? company}){
    _id = id;
    _status = status;
    _type = type;
    _expirationDate = expirationDate;
    _companyId = companyId;
    _modelId = modelId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _company = company;
  }

  CompanyAds.fromJson(dynamic json) {
    _id = json["id"];
    _status = json["status"];
    _type = json["type"];
    _expirationDate = json["expiration_date"];
    _companyId = json["company_id"];
    _modelId = json["model_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _company = json["company"] != null ? Company.fromJson(json["company"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["status"] = _status;
    map["type"] = _type;
    map["expiration_date"] = _expirationDate;
    map["company_id"] = _companyId;
    map["model_id"] = _modelId;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_company != null) {
      map["company"] = _company?.toJson();
    }
    return map;
  }

}