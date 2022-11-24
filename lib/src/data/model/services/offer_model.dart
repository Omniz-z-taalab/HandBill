
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/images.dart';

class OfferModel {
  int? _id;
  String? _companyId;
  String? _minQuantity;
  String? _description;
  double? _oldPrice;
  double? _newPrice;
  String? _title;
  String? _createdAt;
  String? _updatedAt;
  List<ImageModel>? _images;
  Company? _company;


  int? get id => _id;
  String? get companyId => _companyId;
  String? get minQuantity => _minQuantity;
  String? get description => _description;
  double? get oldPrice => _oldPrice;
  double? get newPrice => _newPrice;
  String? get title => _title;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<ImageModel>? get images => _images;
  Company? get company => _company;

  OfferModel({
    int? id,
    String? companyId,
    String? minQuantity,
    String? description,
    double? oldPrice,
    double? newPrice,
    String? title,
    String? createdAt,
    String? updatedAt,
    Company? company,
    List<ImageModel>? images}){
    _id = id;
    _companyId = companyId;
    _minQuantity = minQuantity;
    _description = description;
    _oldPrice = oldPrice;
    _newPrice = newPrice;
    _title = title;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _company = company;
    _images = images;
  }

  OfferModel.fromJson(dynamic json) {
    _id = json["id"];
    _companyId = json["company_id"];
    _minQuantity = json["min_quantity"];
    _description = json["description"];
    _oldPrice = double.parse(json["old_price"]);
    _newPrice = double.parse(json["new_price"]);
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
    map["min_quantity"] = _minQuantity;
    map["description"] = _description;
    map["old_price"] = _oldPrice;
    map["new_price"] = _newPrice;
    map["title"] = _title;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_images != null) {
      map["images"] = _images?.map((v) => v.toJson()).toList();
    }
    if (_company != null) {
      map["company"] = _company?.toJson();
    }
    return map;
  }

}