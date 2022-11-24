import 'package:hand_bill/src/data/model/user.dart';
//
// class EditProfileResponse {
//   bool? _status;
//   User? _data;
//   String? _message;
//
//   bool? get status => _status;
//
//   User? get data => _data;
//
//   String? get message => _message;
//
//   EditProfileResponse({bool? status, User? data, String? message}) {
//     _status = status;
//     _data = data;
//     _message = message;
//   }
//
//   EditProfileResponse.fromJson(dynamic json) {
//     _status = json["status"];
//     _data = json["data"] != null ? User.fromJson(json["data"]) : null;
//     _message = json["message"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["status"] = _status;
//     if (_data != null) {
//       map["data"] = _data?.toJson();
//     }
//     map["message"] = _message;
//     return map;
//   }
// }


class EditProfileResponse {
  bool? status;
  User? data;
  String? message;

  EditProfileResponse({this.status, this.data, this.message});

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
