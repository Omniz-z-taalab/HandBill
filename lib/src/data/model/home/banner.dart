import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/company.dart';

class BannerModel {
  int? _id;
  String? _image;
  String? _companyId;
  Company? _company;

  int? get id => _id;

  String? get image => _image;

  String? get companyId => _companyId;

  Company? get company => _company;

  BannerModel({int? id, String? image, String? companyId, Company? company}) {
    _id = id;
    _image = image;
    _companyId = companyId;
    _company = company;
  }

  BannerModel.fromJson(dynamic json) {
    _id = json["id"];
    _image = APIData.domainLink + json["image"];
    _companyId = json["company_id"];
    _company =
        json["company"] != null ? Company.fromJson(json["company"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["image"] = _image;
    map["company_id"] = _companyId;
    if (_company != null) {
      map["company"] = _company?.toJson();
    }
    return map;
  }
}
