import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/local/video_model.dart';
import 'package:hand_bill/src/data/model/shipping_data.dart';
import 'package:hand_bill/src/data/model/specifications.dart';

class Product {
  dynamic? _id;
  dynamic? _subSubCategoryId;
  dynamic? _isFavourite;
  dynamic? _subCategoryId;
  dynamic? _featured;
  dynamic? _shippingMqo;
  dynamic? _categoryId;
  dynamic? _companyId;
  dynamic? _description;
  dynamic? _country;
  dynamic? _price;
  dynamic? _flag;
  dynamic? _name;
  dynamic? _createdAt;
  dynamic? _updatedAt;
  List<ImageModel>? _images;
  VideoModel? _video;
  ShippingData? _shippingData;
  List<Specifications>? _specifications;
  Company? _company;

  dynamic? get id => _id;

  dynamic? get subSubCategoryId => _subSubCategoryId;

  dynamic? get isFavourite => _isFavourite;

  dynamic? get subCategoryId => _subCategoryId;

  dynamic? get featured => _featured;

  dynamic? get shippingMqo => _shippingMqo;

  dynamic? get categoryId => _categoryId;

  dynamic? get companyId => _companyId;

  dynamic? get description => _description;

  dynamic? get country => _country;

  dynamic? get price => _price;

  dynamic? get flag => _flag;

  dynamic? get name => _name;

  dynamic? get createdAt => _createdAt;

  dynamic? get updatedAt => _updatedAt;

  List<ImageModel>? get images => _images;

  VideoModel? get video => _video;

  ShippingData? get shippingData => _shippingData;

  List<Specifications>? get specifications => _specifications;

  Company? get company => _company;


  Product({
    int? id,
    dynamic? subSubCategoryId,
    dynamic? isFavourite,
    dynamic? subCategoryId,
    dynamic? featured,
    dynamic? shippingMqo,
    dynamic? categoryId,
    dynamic? companyId,
    dynamic? description,
    dynamic? country,
    dynamic? price,
    dynamic? flag,
    dynamic? name,
    dynamic? createdAt,
    dynamic? updatedAt,
    List<ImageModel>? images,
    // VideoModel? video,
    ShippingData? shippingData,
    List<Specifications>? specifications,
    Company? company,
    bool? favorite,
  }) {
    _id = id;
    _subSubCategoryId = subSubCategoryId;
    _isFavourite = isFavourite;
    _subCategoryId = subCategoryId;
    _featured = featured;
    _shippingMqo = shippingMqo;
    _categoryId = categoryId;
    _companyId = companyId;
    _description = description;
    _country = country;
    _price = price;
    _flag = flag;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _images = images;
    // _video = video;
    _shippingData = shippingData;
    _specifications = specifications;
    _company = company;
  }

  Product.fromJson(dynamic json) {
    _id = json["id"];
    _subSubCategoryId = json["sub_sub_category_id"];
    _isFavourite = json["is_favourite"];
    _subCategoryId = json["sub_category_id"];
    _featured = json["featured"];
    _shippingMqo = json["shipping_mqo"];
    _categoryId = json["category_id"];
    _companyId = json["company_id"];
    _description = json["description"];
    _country = json["country"];
    _price = json["price"];
    _flag =
        json["flag"] == null ? placeholder : APIData.domainLink + json["flag"];
    _name = json["name"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images?.add(ImageModel.fromJson(v));
      });
    }
    // _video = json["video"];
    _shippingData = json["shipping_data"] != null
        ? ShippingData.fromJson(json["shipping_data"])
        : null;
    if (json["specifications"] != null) {
      _specifications = [];
      json["specifications"].forEach((v) {
        _specifications?.add(Specifications.fromJson(v));
      });
    }
    _company =
        json["company"] != null ? Company.fromJson(json["company"]) : null;
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map["id"] = _id;
    map["sub_sub_category_id"] = _subSubCategoryId;
    map["is_favourite"] = _isFavourite;
    map["sub_category_id"] = _subCategoryId;
    map["featured"] = _featured;
    map["shipping_mqo"] = _shippingMqo;
    map["category_id"] = _categoryId;
    map["company_id"] = _companyId;
    map["description"] = _description;
    map["country"] = _country;
    map["price"] = _price;
    map["flag"] = _flag;
    map["name"] = _name;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_images != null) {
      map["images"] = _images?.map((v) => v.toJson()).toList();
    }
    map["video"] = _video;
    if (_shippingData != null) {
      map["shipping_data"] = _shippingData?.toJson();
    }
    if (_specifications != null) {
      map["specifications"] = _specifications?.map((v) => v.toJson()).toList();
    }
    if (_company != null) {
      map["company"] = _company?.toJson();
    }
    return map;
  }

  set isFavourite(dynamic? value) {
    _isFavourite = value;
  }
}
