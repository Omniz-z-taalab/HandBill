import 'package:hand_bill/src/data/model/account_package/favorite_model.dart';
import 'package:hand_bill/src/data/model/paginate/links.dart';
import 'package:hand_bill/src/data/model/paginate/meta.dart';

class FavoriteResponse {
  List<FavoriteModel>? data;
  Links? links;
  Meta? meta;
  bool? status;
  String? message;

  FavoriteResponse(
      {this.data, this.links, this.meta, this.status, this.message});

  FavoriteResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FavoriteModel>[];
      json['data'].forEach((v) {
        data!.add(new FavoriteModel.fromJson(v));
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

class Data {
  int? id;
  String? userId;
  String? productId;
  Product? product;

  Data({this.id, this.userId, this.productId, this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? price;
  String? flag;
  List<Images>? images;
  Images? video;

  Product({this.id, this.name, this.price, this.flag, this.images, this.video});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    flag = json['flag'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    video = json['video'] != null ? new Images.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['flag'] = this.flag;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    return data;
  }
}

class Images {
  int? id;
  String? modelId;
  String? description;
  String? modelType;
  String? thump;
  String? icon;
  String? url;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
        this.modelId,
        this.description,
        this.modelType,
        this.thump,
        this.icon,
        this.url,
        this.createdAt,
        this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
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



// class FavoriteResponse {
//   List<FavoriteModel>? _data;
//   Links? _links;
//   Meta? _meta;
//   bool? _status;
//   String? _message;
//
//   List<FavoriteModel>? get data => _data;
//
//   Links? get links => _links;
//
//   Meta? get meta => _meta;
//
//   bool? get status => _status;
//
//   String? get message => _message;
//
//   FavoriteResponse(
//       {List<FavoriteModel>? data,
//         Links? links,
//         Meta? meta,
//         bool? status,
//         String? message}) {
//     _data = data;
//     _links = links;
//     _meta = meta;
//     _status = status;
//     _message = message;
//   }
//
//   FavoriteResponse.fromJson(dynamic json) {
//     if (json["data"] != null) {
//       _data = [];
//       json["data"].forEach((v) {
//         _data?.add(FavoriteModel.fromJson(v));
//       });
//     }
//     _links = json["links"] != null ? Links.fromJson(json["links"]) : null;
//     _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
//     _status = json["status"];
//     _message = json["message"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (_data != null) {
//       map["data"] = _data?.map((v) => v.toJson()).toList();
//     }
//     if (_links != null) {
//       map["links"] = _links?.toJson();
//     }
//     if (_meta != null) {
//       map["meta"] = _meta?.toJson();
//     }
//     map["status"] = _status;
//     map["message"] = _message;
//     return map;
//   }
// }