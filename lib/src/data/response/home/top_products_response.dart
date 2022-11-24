import 'package:hand_bill/src/data/model/home/product_ads.dart';
import 'package:hand_bill/src/data/model/product.dart';

class TopProductsResponse {
  List<Product>? _data;
  bool? _status;
  String? _message;

  List<Product>? get data => _data;

  bool? get status => _status;

  String? get message => _message;

  TopProductsResponse({List<Product>? data, bool? status, String? message}) {
    _data = data;
    _status = status;
    _message = message;
  }

  TopProductsResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(Product.fromJson(v));
      });
    }
    _status = json["status"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data?.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    map["message"] = _message;
    return map;
  }
}
