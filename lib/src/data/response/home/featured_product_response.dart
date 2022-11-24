import 'package:hand_bill/src/data/model/product.dart';
class FeaturedProductsResponse {
  bool? _status;
  List<Product>? _data;
  String? _message;

  bool? get status => _status;

  List<Product>? get data => _data;

  String? get message => _message;

  FeaturedProductsResponse(
      {bool? status, List<Product>? data, String? message}) {
    _status = status;
    _data = data;
    _message = message;
  }

  FeaturedProductsResponse.fromJson(dynamic json) {
    _status = json["status"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data!.add(Product.fromJson(v));
      });
    }
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_data != null) {
      map["data"] = _data!.map((v) => v.toJson()).toList();
    }
    map["message"] = _message;
    return map;
  }
}
