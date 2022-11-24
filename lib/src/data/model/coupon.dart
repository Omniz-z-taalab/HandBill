import 'package:hand_bill/src/data/model/discountables.dart';

class Coupon {
  int? _id;
  String? _code;
  int? _discount;
  String? _discountType;
  String? _description;
  String? _expiresAt;
  bool? _enabled;
  List<Discountables>? _discountables;

  bool? _valid;

  int? get id => _id;

  String? get code => _code;

  int? get discount => _discount;

  String? get discountType => _discountType;

  String? get description => _description;

  String? get expiresAt => _expiresAt;

  bool? get enabled => _enabled;

  List<Discountables>? get discountables => _discountables;

  bool? get valid => _valid;

  Coupon(
      {int? id,
      String? code,
      int? discount,
      String? discountType,
      String? description,
      String? expiresAt,
      bool? enabled,
      List<Discountables>? discountables,
      bool? valid}) {
    _id = id;
    _code = code;
    _discount = discount;
    _discountType = discountType;
    _description = description;
    _expiresAt = expiresAt;
    _enabled = enabled;
    _discountables = discountables;
    _valid = valid;
  }

  Coupon.fromJson(dynamic json) {
    _id = json["id"];
    _code = json["code"];
    _discount = json["discount"];
    _discountType = json["discount_type"];
    _description = json["description"];
    _expiresAt = json["expires_at"];
    _enabled = json["enabled"];
    _valid = json['valid'];

    if (json["discountables"] != null) {
      _discountables = [];
      json["discountables"].forEach((v) {
        _discountables!.add(Discountables.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["code"] = _code;
    map["discount"] = _discount;
    map["discount_type"] = _discountType;
    map["description"] = _description;
    map["expires_at"] = _expiresAt;
    map["enabled"] = _enabled;
    map["valid"] = _valid;

    if (_discountables != null) {
      map["discountables"] = _discountables!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set valid(bool? value) {
    _valid = value;
  }
}
