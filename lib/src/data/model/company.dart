import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/LeftDetailsOfCompany.dart';
import 'package:hand_bill/src/data/model/local/images.dart';

import 'local/video_model.dart';

class Company {
  int? _id;
  dynamic? _natureActivity;
  dynamic? _subNatureActivity;
  dynamic? _isVerified;
  dynamic? _deviceToken;
  dynamic? _banners;
  dynamic? _active;
  dynamic? _offers;
  dynamic? _assets;
  dynamic? _apiToken;
  dynamic? _jobs;
  dynamic? _email;
  dynamic? _name;
  dynamic? _createdAt;
  dynamic? _updatedAt;
  LeftDataOfCompanies? _leftDataOfCompanies;
  List<ImageModel>? _images;
  ImageModel? _logo;
  VideoModel? _video;
  dynamic? _phone;
  dynamic? _country;
  dynamic? _flag;

  int? get id => _id;

  dynamic? get natureActivity => _natureActivity;

  dynamic? get subNatureActivity => _subNatureActivity;

  bool? get isVerified => _isVerified;

  dynamic? get deviceToken => _deviceToken;

  dynamic? get banners => _banners;

  bool? get active => _active;

  dynamic? get offers => _offers;

  dynamic? get assets => _assets;

  dynamic? get apiToken => _apiToken;

  dynamic? get jobs => _jobs;

  dynamic? get email => _email;

  dynamic? get name => _name;

  dynamic? get createdAt => _createdAt;

  dynamic? get updatedAt => _updatedAt;

  LeftDataOfCompanies? get leftDataOfCompanies => _leftDataOfCompanies;

  List<ImageModel>? get images => _images;

  ImageModel? get logo => _logo;

  VideoModel? get video => _video;

  dynamic? get firstPhone => _phone;

  dynamic? get country => _country;

  dynamic? get flag => _flag;

  Company({
    int? id,
    dynamic? natureActivity,
    dynamic? subNatureActivity,
    bool? isVerified,
    dynamic? deviceToken,
    dynamic? banners,
    dynamic? active,
    dynamic? offers,
    dynamic? assets,
    dynamic? apiToken,
    dynamic? jobs,
    dynamic? email,
    dynamic? name,
    dynamic? createdAt,
    dynamic? updatedAt,
    LeftDataOfCompanies? leftDataOfCompanies,
    List<ImageModel>? images,
    ImageModel? logo,
    VideoModel? video,
    dynamic? firstPhone,
    dynamic? country,
    dynamic? flag,
  }) {
    _id = id;
    _natureActivity = natureActivity;
    _subNatureActivity = subNatureActivity;
    _isVerified = isVerified;
    _deviceToken = deviceToken;
    _banners = banners;
    _active = active;
    _offers = offers;
    _assets = assets;
    _apiToken = apiToken;
    _jobs = jobs;
    _email = email;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _leftDataOfCompanies = leftDataOfCompanies;
    _images = images;
    _logo = logo;
    _video = video;
    _phone = firstPhone;
    _country = country;
    _flag = flag;
  }

  Company.fromJson(dynamic json) {
    _id = json["id"];
    _natureActivity = json["nature_activity"];
    _subNatureActivity = json["sub_nature_activity"];
    _isVerified = json["is_verified"];
    _deviceToken = json["device_token"];
    _banners = json["banners"];
    _active = json["active"];
    _offers = json["offers"];
    _assets = json["assets"];
    _apiToken = json["api_token"];
    _jobs = json["jobs"];
    _email = json["email"];
    _name = json["name"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _leftDataOfCompanies = json["left_data_of_companies"] != null
        ? LeftDataOfCompanies.fromJson(json["left_data_of_companies"])
        : null;
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images?.add(ImageModel.fromJson(v));
      });
    }
    _video = json["videos"] != null ? VideoModel.fromJson(json["videos"]) : null;
    _logo = json["logo"] != null ? ImageModel.fromJson(json["logo"]) : null;
    _phone = json["phone"];
    _country = json["country"];
    _flag =
        json["flag"] == null ? placeholder : APIData.domainLink + json["flag"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map["id"] = _id;
    map["nature_activity"] = _natureActivity;
    map["sub_nature_activity"] = _subNatureActivity;
    // map["plan_id"] = _planId;
    map["is_verified"] = _isVerified;
    map["device_token"] = _deviceToken;
    map["active"] = _active;
    map["api_token"] = _apiToken;
    map["email"] = _email;
    map["country"] = _country;
    map["phone"] = _phone;
    map["flag"] = _flag;
    map["name"] = _name;

    if (_leftDataOfCompanies != null) {
      map["left_data_of_companies"] = _leftDataOfCompanies?.toJson();
    }
    if (_images != null) {
      map["images"] = _images?.map((v) => v.toJson()).toList();
    }

    return map;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    // map["thumb"] = logo;
    map["thumb"] = placeholder;
    map["device_token"] = deviceToken;
    return map;
  }
}
