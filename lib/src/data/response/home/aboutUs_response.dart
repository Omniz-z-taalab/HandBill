import 'package:hand_bill/src/data/model/about_us/aboutUsModel.dart';

class AboutUsResponse {
  List<AboutUsModel>? _data;
  bool? _status;
  String? _message;

  List<AboutUsModel>? get data => _data;
  bool? get status => _status;
  String? get message => _message;

  AboutUsResponse({List<AboutUsModel>? data, bool? status, String? message}) {
    _data = data;
    _status = status;
    _message = message;
  }

  AboutUsResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(AboutUsModel.fromJson(v));
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
