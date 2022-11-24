import 'package:hand_bill/src/data/model/helpcenterMode/help-model.dart';

class HelpCenterResponse {
  List<HelpCenterModel>? data;
  bool? status;
  String? message;

  HelpCenterResponse({this.data, this.status, this.message});

  HelpCenterResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HelpCenterModel>[];
      json['data'].forEach((v) {
        data!.add(new HelpCenterModel.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}