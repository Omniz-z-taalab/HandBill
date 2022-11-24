class ShippingData {
  String? _shippingType;
  String? _shippingPackageDetails;
  String? _shippingLeadTime;
  String? _shippingPort;

  String? get shippingType => _shippingType;

  String? get shippingPackageDetails => _shippingPackageDetails;

  String? get shippingLeadTime => _shippingLeadTime;

  String? get shippingPort => _shippingPort;

  ShippingData(
      {int? id,
      String? shippingType,
      String? shippingPackageDetails,
      String? shippingLeadTime,
      String? shippingPort,
      String? productId,
      String? createdAt,
      String? updatedAt}) {
    _shippingType = shippingType;
    _shippingPackageDetails = shippingPackageDetails;
    _shippingLeadTime = shippingLeadTime;
    _shippingPort = shippingPort;
  }

  ShippingData.fromJson(dynamic json) {
    _shippingType = json["shipping_type"];
    _shippingPackageDetails = json["shipping_package_details"];
    _shippingLeadTime = json["shipping_lead_time"];
    _shippingPort = json["shipping_port"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map["shipping_type"] = _shippingType;
    map["shipping_package_details"] = _shippingPackageDetails;
    map["shipping_lead_time"] = _shippingLeadTime;
    map["shipping_port"] = _shippingPort;
    return map;
  }
}
