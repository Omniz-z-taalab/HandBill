import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/product.dart';

import '../../model/company.dart';
import '../../model/shippingData.dart';
import '../../model/shipping_data.dart';
import '../../model/specifications.dart';


// class SearchProductResponse {
//   Products? products;
//   Products? companies;
//   bool? status;
//   String? message;
//
//   SearchProductResponse(
//       {this.products, this.companies, this.status, this.message});
//
//   SearchProductResponse.fromJson(Map<String, dynamic> json) {
//     products = json['products'] != null
//         ? new Products.fromJson(json['products'])
//         : null;
//     companies = json['companies'] != null
//         ? new Products.fromJson(json['companies'])
//         : null;
//     status = json['status'];
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.products != null) {
//       data['products'] = this.products!.toJson();
//     }
//     if (this.companies != null) {
//       data['companies'] = this.companies!.toJson();
//     }
//     data['status'] = this.status;
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class Products {
//   int? currentPage;
//   List<SearchD>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Links>? links;
//   Null? nextPageUrl;
//   String? path;
//   int? perPage;
//   Null? prevPageUrl;
//   int? to;
//   int? total;
//
//   Products(
//       {this.currentPage,
//         this.data,
//         this.firstPageUrl,
//         this.from,
//         this.lastPage,
//         this.lastPageUrl,
//         this.links,
//         this.nextPageUrl,
//         this.path,
//         this.perPage,
//         this.prevPageUrl,
//         this.to,
//         this.total});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <SearchD>[];
//       json['data'].forEach((v) {
//         data!.add(new SearchD.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     if (json['links'] != null) {
//       links = <Links>[];
//       json['links'].forEach((v) {
//         links!.add(new Links.fromJson(v));
//       });
//     }
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = this.firstPageUrl;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['last_page_url'] = this.lastPageUrl;
//     if (this.links != null) {
//       data['links'] = this.links!.map((v) => v.toJson()).toList();
//     }
//     data['next_page_url'] = this.nextPageUrl;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['prev_page_url'] = this.prevPageUrl;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }
//
// class SearchD {
//   int? id;
//   String? name;
//   String? price;
//   String? flag;
//   bool? isFavourite;
//   String? companyId;
//   String? subSubCategoryId;
//   List<ImageModel>? images;
//   Images? video;
//   ShippingData? shippingData;
//   Companies? company;
//
//   SearchD(
//       {this.id,
//         this.name,
//         this.price,
//         this.flag,
//         this.isFavourite,
//         this.companyId,
//         this.subSubCategoryId,
//         this.images,
//         this.video,
//         this.shippingData,
//         this.company});
//
//   SearchD.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     flag = json['flag'];
//     isFavourite = json['is_favourite'];
//     companyId = json['company_id'];
//     subSubCategoryId = json['sub_sub_category_id'];
//     if (json['images'] != null) {
//       images = <ImageModel>[];
//       json['images'].forEach((v) {
//         images!.add(new ImageModel.fromJson(v));
//       });
//     }
//     // video = json['video'] != null ? new Images.fromJson(json['video']) : null;
//     // shippingData = json['shipping_data'] != null
//     //     ? new ShippingData.fromJson(json['shipping_data'])
//     //     : null;
//     company =
//     json['company'] != null ? new Companies.fromJson(json['company']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['flag'] = this.flag;
//     data['is_favourite'] = this.isFavourite;
//     data['company_id'] = this.companyId;
//     data['sub_sub_category_id'] = this.subSubCategoryId;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     if (this.video != null) {
//       data['video'] = this.video!.toJson();
//     }
//     if (this.shippingData != null) {
//       data['shipping_data'] = this.shippingData!.toJson();
//     }
//     if (this.company != null) {
//       data['company'] = this.company!.toJson();
//     }
//     return data;
//   }
// }
//
// class Images {
//   int? id;
//   String? modelId;
//   String? description;
//   String? modelType;
//   String? thump;
//   String? icon;
//   String? url;
//   String? createdAt;
//   String? updatedAt;
//
//   Images(
//       {this.id,
//         this.modelId,
//         this.description,
//         this.modelType,
//         this.thump,
//         this.icon,
//         this.url,
//         this.createdAt,
//         this.updatedAt});
//
//   Images.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     modelId = json['model_id'];
//     description = json['description'];
//     modelType = json['model_type'];
//     thump = json['thump'];
//     icon = json['icon'];
//     url = json['url'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['model_id'] = this.modelId;
//     data['description'] = this.description;
//     data['model_type'] = this.modelType;
//     data['thump'] = this.thump;
//     data['icon'] = this.icon;
//     data['url'] = this.url;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class ShippingData {
//   int? id;
//   String? shippingType;
//   String? shippingPackageDetails;
//   String? shippingLeadTime;
//   String? shippingPort;
//   String? productId;
//   String? createdAt;
//   String? updatedAt;
//   Null? detailsAr;
//
//   ShippingData(
//       {this.id,
//         this.shippingType,
//         this.shippingPackageDetails,
//         this.shippingLeadTime,
//         this.shippingPort,
//         this.productId,
//         this.createdAt,
//         this.updatedAt,
//         this.detailsAr});
//
//   ShippingData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     shippingType = json['shipping_type'];
//     shippingPackageDetails = json['shipping_package_details'];
//     shippingLeadTime = json['shipping_lead_time'];
//     shippingPort = json['shipping_port'];
//     productId = json['product_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     detailsAr = json['details_ar'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['shipping_type'] = this.shippingType;
//     data['shipping_package_details'] = this.shippingPackageDetails;
//     data['shipping_lead_time'] = this.shippingLeadTime;
//     data['shipping_port'] = this.shippingPort;
//     data['product_id'] = this.productId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['details_ar'] = this.detailsAr;
//     return data;
//   }
// }
//
// class Companies {
//   int? id;
//   String? name;
//   List<Images>? images;
//   Null? videos;
//   Images? logo;
//
//   Companies({this.id, this.name, this.images, this.videos, this.logo});
//
//   Companies.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     videos = json['videos'];
//     logo = json['logo'] != null ? new Images.fromJson(json['logo']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     data['videos'] = this.videos;
//     if (this.logo != null) {
//       data['logo'] = this.logo!.toJson();
//     }
//     return data;
//   }
// }
//
// class Links {
//   String? url;
//   String? label;
//   bool? active;
//
//   Links({this.url, this.label, this.active});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     label = json['label'];
//     active = json['active'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['label'] = this.label;
//     data['active'] = this.active;
//     return data;
//   }
// }
//
// class SearchProduct {
//   int? id;
//   String? natureActivity;
//   Null? subNatureActivity;
//   String? hasFirstImage;
//   String? planId;
//   String? isVerified;
//   String? hasLogo;
//   String? hasData;
//   String? deviceToken;
//   String? expirationDate;
//   String? active;
//   String? apiToken;
//   String? email;
//   String? country;
//   String? phone;
//   String? flag;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//   String? representativeAble;
//   Null? representativeNote;
//   String? fromDate;
//   String? toDate;
//   Null? emailVerifiedAt;
//   String? categoryId;
//   Null? nameAr;
//
//   SearchProduct(
//       {this.id,
//         this.natureActivity,
//         this.subNatureActivity,
//         this.hasFirstImage,
//         this.planId,
//         this.isVerified,
//         this.hasLogo,
//         this.hasData,
//         this.deviceToken,
//         this.expirationDate,
//         this.active,
//         this.apiToken,
//         this.email,
//         this.country,
//         this.phone,
//         this.flag,
//         this.name,
//         this.createdAt,
//         this.updatedAt,
//         this.representativeAble,
//         this.representativeNote,
//         this.fromDate,
//         this.toDate,
//         this.emailVerifiedAt,
//         this.categoryId,
//         this.nameAr});
//
//   SearchProduct.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     natureActivity = json['nature_activity'];
//     subNatureActivity = json['sub_nature_activity'];
//     hasFirstImage = json['has_first_image'];
//     planId = json['plan_id'];
//     isVerified = json['is_verified'];
//     hasLogo = json['has_logo'];
//     hasData = json['has_data'];
//     deviceToken = json['device_token'];
//     expirationDate = json['expiration_date'];
//     active = json['active'];
//     apiToken = json['api_token'];
//     email = json['email'];
//     country = json['country'];
//     phone = json['phone'];
//     flag = json['flag'];
//     name = json['name'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     representativeAble = json['representative_able'];
//     representativeNote = json['representative_note'];
//     fromDate = json['from_date'];
//     toDate = json['to_date'];
//     emailVerifiedAt = json['email_verified_at'];
//     categoryId = json['category_id'];
//     nameAr = json['name_ar'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['nature_activity'] = this.natureActivity;
//     data['sub_nature_activity'] = this.subNatureActivity;
//     data['has_first_image'] = this.hasFirstImage;
//     data['plan_id'] = this.planId;
//     data['is_verified'] = this.isVerified;
//     data['has_logo'] = this.hasLogo;
//     data['has_data'] = this.hasData;
//     data['device_token'] = this.deviceToken;
//     data['expiration_date'] = this.expirationDate;
//     data['active'] = this.active;
//     data['api_token'] = this.apiToken;
//     data['email'] = this.email;
//     data['country'] = this.country;
//     data['phone'] = this.phone;
//     data['flag'] = this.flag;
//     data['name'] = this.name;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['representative_able'] = this.representativeAble;
//     data['representative_note'] = this.representativeNote;
//     data['from_date'] = this.fromDate;
//     data['to_date'] = this.toDate;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['category_id'] = this.categoryId;
//     data['name_ar'] = this.nameAr;
//     return data;
//   }
// }

class SearchProductResponse {
  AllDataSearch? data;
  bool? status;
  String? message;

  SearchProductResponse({this.data, this.status, this.message});

  SearchProductResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AllDataSearch.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class AllDataSearch {
  Products? products;
  Companies? companies;

  AllDataSearch({this.products, this.companies});

  AllDataSearch.fromJson(Map<String, dynamic> json) {
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
    companies = json['companies'] != null
        ? new Companies.fromJson(json['companies'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    if (this.companies != null) {
      data['companies'] = this.companies!.toJson();
    }
    return data;
  }
}

class Products {
  int? currentPage;
  List<DataProductSearch>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Products(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataProductSearch>[];
      json['data'].forEach((v) {
        data!.add(new DataProductSearch.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class DataProductSearch {
  int? id;
  List<Specifications>? specifications;
  String? name;
  String? price;
  String? flag;
  bool? isFavourite;
  String? companyId;
  String? subSubCategoryId;
  List<ImageModel>? images;
  ImageModel? video;
  ShippingData? shippingData;
  Company? company;

  DataProductSearch(
      {this.id,
        this.name,
        this.price,
        this.flag,
        this.isFavourite,
        this.companyId,
        this.subSubCategoryId,
        this.images,
        this.video,
        this.shippingData,
        this.company});

  DataProductSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    flag = json['flag'];
    isFavourite = json['is_favourite'];
    companyId = json['company_id'];
    subSubCategoryId = json['sub_sub_category_id'];
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(new ImageModel.fromJson(v));
      });
    }
    video = json['video'] != null ? new ImageModel.fromJson(json['video']) : null;
    shippingData = json['shipping_data'] != null
        ? new ShippingData.fromJson(json['shipping_data'])
        : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    if (json["specifications"] != null) {
      specifications = [];
      json["specifications"].forEach((v) {
        specifications?.add(Specifications.fromJson(v));
      });}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['flag'] = this.flag;
    data['is_favourite'] = this.isFavourite;
    data['company_id'] = this.companyId;
    data['sub_sub_category_id'] = this.subSubCategoryId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    if (this.shippingData != null) {
      data['shipping_data'] = this.shippingData!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
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
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class Companies {
  int? currentPage;
  List<DataCompanySearch>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Companies(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Companies.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataCompanySearch>[];
      json['data'].forEach((v) {
        data!.add(new DataCompanySearch.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class DataCompanySearch {
  int? id;
  String? natureActivity;
  String? subNatureActivity;
  String? hasFirstImage;
  String? planId;
  bool? isVerified;
  String? hasLogo;
  String? hasData;
  String? deviceToken;
  String? expirationDate;
  bool? active;
  String? apiToken;
  String? email;
  String? country;
  String? phone;
  String? flag;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? representativeAble;
  dynamic? representativeNote;
  String? fromDate;
  String? toDate;
  dynamic? emailVerifiedAt;
  String? categoryId;
  String? nameAr;

  DataCompanySearch(
      {this.id,
        this.natureActivity,
        this.subNatureActivity,
        this.hasFirstImage,
        this.planId,
        this.isVerified,
        this.hasLogo,
        this.hasData,
        this.deviceToken,
        this.expirationDate,
        this.active,
        this.apiToken,
        this.email,
        this.country,
        this.phone,
        this.flag,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.representativeAble,
        this.representativeNote,
        this.fromDate,
        this.toDate,
        this.emailVerifiedAt,
        this.categoryId,
        this.nameAr});

  DataCompanySearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    natureActivity = json['nature_activity'];
    subNatureActivity = json['sub_nature_activity'];
    hasFirstImage = json['has_first_image'];
    planId = json['plan_id'];
    isVerified = json['is_verified'];
    hasLogo = json['has_logo'];
    hasData = json['has_data'];
    deviceToken = json['device_token'];
    expirationDate = json['expiration_date'];
    active = json['active'];
    apiToken = json['api_token'];
    email = json['email'];
    country = json['country'];
    phone = json['phone'];
    flag = json['flag'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    representativeAble = json['representative_able'];
    representativeNote = json['representative_note'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    emailVerifiedAt = json['email_verified_at'];
    categoryId = json['category_id'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nature_activity'] = this.natureActivity;
    data['sub_nature_activity'] = this.subNatureActivity;
    data['has_first_image'] = this.hasFirstImage;
    data['plan_id'] = this.planId;
    data['is_verified'] = this.isVerified;
    data['has_logo'] = this.hasLogo;
    data['has_data'] = this.hasData;
    data['device_token'] = this.deviceToken;
    data['expiration_date'] = this.expirationDate;
    data['active'] = this.active;
    data['api_token'] = this.apiToken;
    data['email'] = this.email;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['flag'] = this.flag;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['representative_able'] = this.representativeAble;
    data['representative_note'] = this.representativeNote;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['category_id'] = this.categoryId;
    data['name_ar'] = this.nameAr;
    return data;
  }
}