import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/paginate/links.dart';
import 'package:hand_bill/src/data/model/paginate/meta.dart';
import 'package:hand_bill/src/data/model/product.dart';

class ProductsResponse {
  List<Product>? _data;
  Links? _links;
  Meta? _meta;
  bool? _status;
  String? _message;

  List<Product>? get data => _data;

  Links? get links => _links;

  Meta? get meta => _meta;

  bool? get status => _status;

  String? get message => _message;

  ProductsResponse(
      {List<Product>? data,
      Links? links,
      Meta? meta,
      bool? status,
      String? message}) {
    _data = data;
    _links = links;
    _meta = meta;
    _status = status;
    _message = message;
  }

  ProductsResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(Product.fromJson(v));
      });
    }
    _links = json["links"] != null ? Links.fromJson(json["links"]) : null;
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
    _status = json["status"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data?.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map["links"] = _links?.toJson();
    }
    if (_meta != null) {
      map["meta"] = _meta?.toJson();
    }
    map["status"] = _status;
    map["message"] = _message;
    return map;
  }
}



