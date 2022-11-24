import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/images.dart';

class AssetsModel {
  int? _id;
  String? _companyId;
  String? _propertyType;
  String? _description;
  String? _location;
  String? _price;
  String? _title;
  String? _createdAt;
  String? _updatedAt;
  Company? _company;
  List<ImageModel>? _images;

  int? get id => _id;
  String? get companyId => _companyId;
  String? get propertyType => _propertyType;
  String? get description => _description;
  String? get location => _location;
  String? get price => _price;
  String? get title => _title;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Company? get company => _company;
  List<ImageModel>? get images => _images;

  AssetsModel({
    int? id,
    String? companyId,
    String? propertyType,
    String? description,
    String? location,
    String? price,
    String? title,
    String? createdAt,
    String? updatedAt,
    Company? company,  List<ImageModel>? images}){
    _id = id;
    _companyId = companyId;
    _propertyType = propertyType;
    _description = description;
    _location = location;
    _price = price;
    _title = title;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _company = company;
    _images = images;
  }

  AssetsModel.fromJson(dynamic json) {
    _id = json["id"];
    _companyId = json["company_id"];
    _propertyType = json["property_type"];
    _description = json["description"];
    _location = json["location"];
    _price = json["price"];
    _title = json["title"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _company = json["company"] != null ? Company.fromJson(json["company"]) : null;
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images?.add(ImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["company_id"] = _companyId;
    map["property_type"] = _propertyType;
    map["description"] = _description;
    map["location"] = _location;
    map["price"] = _price;
    map["title"] = _title;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_company != null) {
      map["company"] = _company?.toJson();
    }
    if (_images != null) {
      map["images"] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}