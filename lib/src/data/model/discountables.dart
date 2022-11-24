class Discountables {
  int? _id;
  int? _couponId;
  String? _discountableType;
  int? _discountableId;

  int? get id => _id;
  int? get couponId => _couponId;
  String? get discountableType => _discountableType;
  int? get discountableId => _discountableId;

  Discountables({
    int? id,
    int? couponId,
    String? discountableType,
    int? discountableId}){
    _id = id;
    _couponId = couponId;
    _discountableType = discountableType;
    _discountableId = discountableId;
  }

  Discountables.fromJson(dynamic json) {
    _id = json["id"];
    _couponId = json["coupon_id"];
    _discountableType = json["discountable_type"];
    _discountableId = json["discountable_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["coupon_id"] = _couponId;
    map["discountable_type"] = _discountableType;
    map["discountable_id"] = _discountableId;
    return map;
  }

}