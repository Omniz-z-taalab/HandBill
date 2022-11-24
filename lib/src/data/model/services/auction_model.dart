import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/local/video_model.dart';

class AuctionModel {
  int? _id;
  String? _companyId;
  String? _description;
  String? _title;
  String? _price;
  Company? _company;
  VideoModel? _video;
  List<ImageModel>? _images;

  int? get id => _id;
  String? get companyId => _companyId;
  String? get description => _description;
  String? get title => _title;
  String? get price => _price;
  Company? get company => _company;
  VideoModel? get video => _video;
  List<ImageModel>? get images => _images;

  AuctionModel({
    int? id,
    String? companyId,
    String? description,
    String? title,
    String? price,
    Company? company,
    VideoModel? video,
    List<ImageModel>? images}){
    _id = id;
    _companyId = companyId;
    _description = description;
    _title = title;
    _price = price;
    _company = company;
    _video = video;
    _images = images;
  }

  AuctionModel.fromJson(dynamic json) {
    _id = json["id"];
    _companyId = json["company_id"];
    _description = json["description"];
    _title = json["title"];
    _price = json["price"];
    _company = json["company"] != null ? Company.fromJson(json["company"]) : null;
    _video = json["video"] != null ? VideoModel.fromJson(json["video"]) : null;
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
    map["description"] = _description;
    map["title"] = _title;
    map["price"] = _price;
    if (_company != null) {
      map["company"] = _company?.toJson();
    }
    if (_video != null) {
      map["video"] = _video?.toJson();
    }
    if (_images != null) {
      map["images"] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}