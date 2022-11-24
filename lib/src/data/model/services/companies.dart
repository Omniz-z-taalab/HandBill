import 'package:hand_bill/src/data/model/local/images.dart';

class CompanyModel {
  List<Data>? data;
  Links? links;
  Meta? meta;

  CompanyModel({this.data, this.links, this.meta});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? name;
  String? flag;
  String? phone;
  String? country;
  String? email;
  Logo? logo;
  String? secondEmail;
  String? website;
  String? instagram;
  String? hotLine;
  String? facebook;
  String? whatsApp;
  String? firstMobile;
  String? services;
  String? twitter;
  String? commercialRegister;
  String? companyInfo;
  String? taxCard;
  String? address;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    flag = json['flag'];
    phone = json['phone'];
    country = json['country'];
    email = json['email'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
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
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
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

class Logo {
  int? id;
  String? modelId;
  String? description;
  String? modelType;
  String? thump;
  String? icon;
  String? url;
  String? createdAt;
  String? updatedAt;

  Logo(
      {this.id,
        this.modelId,
        this.description,
        this.modelType,
        this.thump,
        this.icon,
        this.url,
        this.createdAt,
        this.updatedAt});

  Logo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['model_id'];
    description = json['description'];
    modelType = json['model_type'];
    thump = json['thump'];
    icon = json['icon'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_id'] = this.modelId;
    data['description'] = this.description;
    data['model_type'] = this.modelType;
    data['thump'] = this.thump;
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class Links {
  String? first;
  String? last;
  Null? prev;
  Null? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
