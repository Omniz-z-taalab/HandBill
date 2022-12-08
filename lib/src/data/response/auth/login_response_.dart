import 'package:hand_bill/src/data/model/services/handmade_model.dart';
import 'package:hand_bill/src/data/model/user.dart';

class LoginResponse {
  bool? _status;
  User? _data;
  String? _message;

  bool? get status => _status;
  User? get data => _data;
  String? get message => _message;

  LoginResponse({
      bool? status, 
      User? data,
      String? message}){
    _status = status;
    _data = data;
    _message = message;
}

  LoginResponse.fromJson(dynamic json) {
    _status = json["status"];
    _data = json["data"] != null ? User.fromJson(json["data"]) : null;
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_data != null) {
      map["data"] = _data?.toJson();
    }
    map["message"] = _message;
    return map;
  }

}

