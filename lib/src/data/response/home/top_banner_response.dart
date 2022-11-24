import 'package:hand_bill/src/data/model/home/banner.dart';

class TopBannerResponse {
  List<BannerModel>? _data;
  bool? _status;
  String? _message;

  List<BannerModel>? get data => _data;
  bool? get status => _status;
  String? get message => _message;

  TopBannerResponse({
      List<BannerModel>? data, 
      bool? status, 
      String? message}){
    _data = data;
    _status = status;
    _message = message;
}

  TopBannerResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(BannerModel.fromJson(v));
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


