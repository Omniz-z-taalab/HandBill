import 'package:hand_bill/src/data/model/account_package/favorite_model.dart';

class AddToFavoriteResponse {
  bool? _status;
  FavoriteModel? _data;
  String? _message;

  bool? get status => _status;

  FavoriteModel? get data => _data;

  String? get message => _message;

  AddToFavoriteResponse({bool? status, FavoriteModel? data, String? message}) {
    _status = status;
    _data = data;
    _message = message;
  }

  AddToFavoriteResponse.fromJson(dynamic json) {
    _status = json["status"];
    _data = json["data"] != null ? FavoriteModel.fromJson(json["data"]) : null;
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_data != null) {
      map["data"] = _data!.toJson();
    }
    map["message"] = _message;
    return map;
  }
}
