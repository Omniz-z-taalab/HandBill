import '../product.dart';

class ProductAds {
  int? _id;
  String? _status;
  String? _type;
  dynamic? _expirationDate;
  String? _companyId;
  String? _modelId;
  String? _createdAt;
  String? _updatedAt;
  Product? _product;

  int? get id => _id;
  String? get status => _status;
  String? get type => _type;
  dynamic? get expirationDate => _expirationDate;
  String? get companyId => _companyId;
  String? get modelId => _modelId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Product? get product => _product;

  ProductAds({
    int? id,
    String? status,
    String? type,
    dynamic? expirationDate,
    String? companyId,
    String? modelId,
    String? createdAt,
    String? updatedAt,
    Product? product}){
    _id = id;
    _status = status;
    _type = type;
    _expirationDate = expirationDate;
    _companyId = companyId;
    _modelId = modelId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _product = product;
  }

  ProductAds.fromJson(dynamic json) {
    _id = json["id"];
    _status = json["status"];
    _type = json["type"];
    _expirationDate = json["expiration_date"];
    _companyId = json["company_id"];
    _modelId = json["model_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _product = json["product"] != null ? Product.fromJson(json["product"]) : null;
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
    if (_product != null) {
      map["product"] = _product?.toJson();
    }
    return map;
  }

}