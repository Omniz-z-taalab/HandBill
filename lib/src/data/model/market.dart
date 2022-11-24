import 'package:hand_bill/src/data/model/media.dart';
import 'package:hand_bill/src/data/model/user.dart';

class Market {
  int? _marketCount;
  int? _id;
  String? _name;
  String? _description;
  String? _address;
  String? _latitude;
  String? _longitude;
  String? _phone;
  String? _mobile;
  String? _information;
  double? _adminCommission;
  double? _deliveryFee;
  double? _deliveryRange;
  double? _defaultTax;
  bool? _closed;
  bool? _availableForDelivery;
  String? _createdAt;
  String? _updatedAt;
  bool? _active;
  List<dynamic>? _customFields;
  bool? _hasMedia;
  String? _rate;
  Media? _media;
  double? _distance;
  List<User>? _users;

  String? _flag;

  int? get marketCount => _marketCount;

  int? get id => _id;

  String? get name => _name;

  String? get description => _description;

  String? get address => _address;

  String? get latitude => _latitude;

  String? get longitude => _longitude;

  String? get phone => _phone;

  String? get mobile => _mobile;

  String? get information => _information;

  double? get adminCommission => _adminCommission;

  double? get deliveryFee => _deliveryFee;

  double? get deliveryRange => _deliveryRange;

  double? get defaultTax => _defaultTax;

  bool? get closed => _closed;

  bool? get availableForDelivery => _availableForDelivery;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  bool? get active => _active;

  List<dynamic>? get customFields => _customFields;

  bool? get hasMedia => _hasMedia;

  String? get rate => _rate;

  Media? get media => _media;

  double? get distance => _distance;

  List<User>? get users => _users;

  String? get flag => _flag;

  Market(
      {int? marketCount,
      int? id,
      String? name,
      String? description,
      String? address,
      String? latitude,
      String? longitude,
      String? phone,
      String? mobile,
      String? information,
      double? adminCommission,
      double? deliveryFee,
      double? deliveryRange,
      double? defaultTax,
      bool? closed,
      bool? availableForDelivery,
      String? createdAt,
      String? updatedAt,
      bool? active,
      List<dynamic>? customFields,
      bool? hasMedia,
      String? rate,
      Media? media,
      double? distance,
      List<User>? users,
      String? flag}) {
    _marketCount = marketCount;
    _id = id;
    _name = name;
    _description = description;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
    _phone = phone;
    _mobile = mobile;
    _information = information;
    _adminCommission = adminCommission;
    _deliveryFee = deliveryFee;
    _deliveryRange = deliveryRange;
    _defaultTax = defaultTax;
    _closed = closed;
    _availableForDelivery = availableForDelivery;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _active = active;
    _customFields = customFields;
    _hasMedia = hasMedia;
    _rate = rate;
    _media = media;
    _distance = distance;
    _users = users;
    _flag = flag;
  }

  Market.fromJson(dynamic json) {
    _marketCount = json["market_count"];
    _id = json["id"];
    _name = json["name"];
    _description = json["description"];
    _address = json["address"];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _phone = json["phone"];
    _mobile = json["mobile"];
    _information = json["information"];
    _adminCommission = json["admin_commission"] == null
        ? 0.0
        : json["admin_commission"].toDouble();
    _deliveryFee =
        json["delivery_fee"] == null ? 0.0 : json["delivery_fee"].toDouble();
    _deliveryRange = json["delivery_range"] == null
        ? 0.0
        : json["delivery_range"].toDouble();
    _defaultTax =
        json["default_tax"] == null ? 0.0 : json["default_tax"].toDouble();
    _closed = json["closed"];
    _availableForDelivery = json["available_for_delivery"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _active = json["active"];
    if (json["custom_fields"] != null) {
      _customFields = [];
      json["custom_fields"].forEach((v) {
        // _customFields.add(dynamic.fromJson(v));
      });
    }
    _hasMedia = json["has_media"];
    _rate = json["rate"];
    _distance = json['distance'] != null
        ? double.parse(json['distance'].toString())
        : 0.0;
    _media = json["media"] != null && (json["media"] as List).length > 0
        ? Media.fromJSON(json["media"][0])
        : new Media();
    _flag =
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/255px-Flag_of_the_People%27s_Republic_of_China.svg.png";
    _users = json['users'] != null && (json['users'] as List).length > 0
        ? List.from(json['users'])
            .map((element) => User.fromJson(element))
            .toSet()
            .toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["latitude"] = _latitude;
    map["longitude"] = _longitude;
    map["delivery_fee"] = _deliveryFee;
    map["distance"] = _distance;

    return map;
  }
}
