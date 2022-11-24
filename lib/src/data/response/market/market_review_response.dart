import 'package:hand_bill/src/data/model/review.dart';

class ReviewResponse {
  bool? _status;
  List<Review>? _data;
  String? _message;

  bool? get status => _status;

  List<Review>? get data => _data;

  String? get message => _message;

  ReviewResponse({bool? success, List<Review>? data, String? message}) {
    _status = success;
    _data = data;
    _message = message;
  }

  ReviewResponse.fromJson(dynamic json) {
    _status = json["status"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data!.add(Review.fromJSON(v));
      });
    }
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_data != null) {
      map["data"] = _data!.map((v) => v.toMap()).toList();
    }
    map["message"] = _message;
    return map;
  }
}
