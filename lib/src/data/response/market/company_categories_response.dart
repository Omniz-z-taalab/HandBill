import 'package:hand_bill/src/data/model/category/category.dart';

class CompanyCategoriesResponse {
  bool? _status;
  List<CategoryModel>? _data;
  String? _message;

  bool? get status => _status;

  List<CategoryModel>? get data => _data;

  String? get message => _message;

  CompanyCategoriesResponse(
      {bool? success, List<CategoryModel>? data, String? message}) {
    _status = success;
    _data = data;
    _message = message;
  }

  CompanyCategoriesResponse.fromJson(dynamic json) {
    _status = json["status"];
    if (json["data"] != null) {
      _data = [];
      // json["data"].forEach((v) {
      //   _data!.add(CategoryModel.fromJson(v));
      // });
    }
    _message = json["message"];
  }
}
