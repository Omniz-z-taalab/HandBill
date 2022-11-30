import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/paginate/meta.dart';

import '../../../model/paginate/links.dart';

class ServiceCompanyResponse {
  List<ServiceCompanyModel>? data;
  Links? links;
  Meta? meta;

  ServiceCompanyResponse({this.data, this.links, this.meta});

  ServiceCompanyResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ServiceCompanyModel>[];
      json['data'].forEach((v) {
        data!.add(new ServiceCompanyModel.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
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
    return data;
  }
}

class ServiceCompanyModel {
  int? id;
  String? name;
  String? flag;
  String? phone;
  String? country;
  String? email;
  ImageModel? logo;
  String? secondEmail;
  dynamic? website;
  String? instagram;
  dynamic? hotLine;
  dynamic? facebook;
  dynamic? whatsApp;
  dynamic? firstMobile;
  dynamic? services;
  dynamic? twitter;
  dynamic? commercialRegister;
  dynamic? companyInfo;
  dynamic? taxCard;
  String? address;

  ServiceCompanyModel(
      {this.id,
        this.name,
        this.flag,
        this.phone,
        this.country,
        this.email,
        this.logo,
        this.secondEmail,
        this.website,
        this.instagram,
        this.hotLine,
        this.facebook,
        this.whatsApp,
        this.firstMobile,
        this.services,
        this.twitter,
        this.commercialRegister,
        this.companyInfo,
        this.taxCard,
        this.address});

  ServiceCompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    flag = json['flag'];
    phone = json['phone'];
    country = json['country'];
    email = json['email'];
    logo = json['logo'];
    secondEmail = json['second_email'];
    website = json['website'];
    instagram = json['instagram'];
    hotLine = json['hot_line'];
    facebook = json['facebook'];
    whatsApp = json['whatsApp'];
    firstMobile = json['firstMobile'];
    services = json['services'];
    twitter = json['twitter'];
    commercialRegister = json['commercial_register'];
    companyInfo = json['company_info'];
    taxCard = json['tax_card'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['flag'] = this.flag;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['email'] = this.email;
    data['logo'] = this.logo;
    data['second_email'] = this.secondEmail;
    data['website'] = this.website;
    data['instagram'] = this.instagram;
    data['hot_line'] = this.hotLine;
    data['facebook'] = this.facebook;
    data['whatsApp'] = this.whatsApp;
    data['firstMobile'] = this.firstMobile;
    data['services'] = this.services;
    data['twitter'] = this.twitter;
    data['commercial_register'] = this.commercialRegister;
    data['company_info'] = this.companyInfo;
    data['tax_card'] = this.taxCard;
    data['address'] = this.address;
    return data;
  }
}