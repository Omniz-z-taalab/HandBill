import '../../model/serviceCategories_model.dart';

class ServiceResponse {
  List<ServiceCategoryModel>? _data;
  bool? _status;
  String? _message;

  List<ServiceCategoryModel>? get data => _data;
  bool? get status => _status;
  String? get message => _message;

  CategoriesResponse(
      {List<ServiceCategoryModel>? data, bool? status, String? message}) {
    _data = data;
    _status = status;
    _message = message;
  }

  ServiceResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(ServiceCategoryModel.fromJson(v));
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
class ServicecategoryResponse {
  List<ServiceModel>? _data;
  bool? _status;
  String? _message;

  List<ServiceModel>? get data => _data;
  bool? get status => _status;
  String? get message => _message;

  CategoriesResponse(
      {List<ServiceModel>? data, bool? status, String? message}) {
    _data = data;
    _status = status;
    _message = message;
  }

  ServicecategoryResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(ServiceModel.fromJson(v));
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
