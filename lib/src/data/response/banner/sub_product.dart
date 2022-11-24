import '../../model/company.dart';
import '../../model/paginate/links.dart';
import '../../model/paginate/meta.dart';

class BannerSubResponse {
  List<DataPro>? data;
  Links? links;
  Meta? meta;
  bool? status;
  String? message;

  BannerSubResponse(
      {this.data, this.links, this.meta, this.status, this.message});

  BannerSubResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataPro>[];
      json['data'].forEach((v) {
        data!.add(new DataPro.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class DataPro {
  int? id;
  String? image;
  String? companyId;
  Company? company;

  DataPro({this.id, this.image, this.companyId, this.company});

  DataPro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    companyId = json['company_id'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['company_id'] = this.companyId;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}
