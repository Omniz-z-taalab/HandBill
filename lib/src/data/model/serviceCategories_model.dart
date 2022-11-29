// class ServiceCategoryModel {
//   List<Data>? data;
//   bool? status;
//   String? message;
//   bool? selected;

//   ServiceCategoryModel({this.data, this.status, this.message});

//   ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     status = json['status'];
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['status'] = this.status;
//     data['message'] = this.message;
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? name;
//   String? description;
//   String? createdAt;
//   String? updatedAt;
//   Null? deletedAt;
//   String? image;

//   Data(
//       {this.id,
//       this.name,
//       this.description,
//       this.createdAt,
//       this.updatedAt,
//       this.deletedAt,
//       this.image});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//     image = json['image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     data['image'] = this.image;
//     return data;
//   }
// }
import 'local/images.dart';
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
class ServiceModel {
  // List<SubCategoryModel>? subCategoryModel;
  // set setSubCategories(List<SubCategoryModel>? value) {
  //   subCategoryModel = value;
  // }
  //
  // get subCategories => subCategoryModel;

  dynamic? _id;
  dynamic? _name;
  dynamic? _description;
  dynamic? _createdAt;
  dynamic? _updatedAt;
  dynamic? _deletedAt;
  List<ImageModel>? _image;
  bool? _selected;
  dynamic? get id => _id;

  dynamic? get name => _name;

  dynamic? get description => _description;

  List<ImageModel>? get image => _image;
  dynamic? get createdAt => _createdAt;

  dynamic? get deletedAt => _deletedAt;

  dynamic? get updatedAt => _updatedAt;

  ServiceModel(
      {dynamic? id, dynamic? name, dynamic? selected, List<ImageModel>? image,dynamic? createdAt,dynamic? description,dynamic? updatedAt,dynamic? deletedAt}) {
    _id = id;
    _name = name;
    _image = image;
    _createdAt = createdAt;
    _description = description;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  ServiceModel.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    // _image = json["image"];
    _createdAt = json["created_at"];
    _description = json["description"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];

  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    // map["image"] = _image;
    map["created_at"] =_createdAt;
    map["description"] = _description;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    return map;
  }

  set selected(bool? value) {
    _selected = value;
  }
}

// class ServiceCategoryModel {
//   // List<SubCategoryModel>? subCategoryModel;
//   // set setSubCategories(List<SubCategoryModel>? value) {
//   //   subCategoryModel = value;
//   // }
//   //
//   // get subCategories => subCategoryModel;
//
//   dynamic? _id;
//   dynamic? _name;
//   dynamic? _image;
//   dynamic? _selected;
//
//   dynamic? get id => _id;
//
//   dynamic? get name => _name;
//   ImageModel get image => _image;
//
//   bool? get selected => _selected;
//
//   ServiceCategoryModel(
//       {dynamic? id, dynamic? name, dynamic? selected,ImageModel? image}) {
//     _id = id;
//     _name = name;
//     _selected = selected;
//     _image = image;
//   }
//
//   ServiceCategoryModel.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _image = json["image"];
//
//     _selected = false;
//   }
//
//   Map<dynamic, dynamic> toJson() {
//     var map = <dynamic, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["image"] = _image;
//
//     return map;
//   }
//
//
// }
class ServiceCategoryModel {
List<GetDataCategory>? data;
bool? status;
String? message;


ServiceCategoryModel({this.data, this.status, this.message});

ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
if (json['data'] != null) {
data = <GetDataCategory>[];
json['data'].forEach((v) {
data!.add(new GetDataCategory.fromJson(v));
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

class GetDataCategory {
  int? _id;
  String? _name;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  Null? _deletedAt;
  Imagess? _image;
  bool? _selected;
  bool? get selected => _selected;
int? get id => _id;
  String? get name  => _name;
  String? get description  => _description;
  String? get createdAt  => _createdAt;
  String? get updatedAt  => _updatedAt;
  Null? get deletedAt  => _deletedAt;
  Imagess? get image  => _image;
  GetDataCategory(
      {
        bool? selected,
        String? name,
        String? description,
        String? createdAt,
        String? updatedAt,
        // Imagess? _image,
      }

      ){
    _id =id;
    _selected = selected;
    _image = image;
    _deletedAt = deletedAt;
    _description= description;
    _updatedAt =updatedAt;
    _createdAt =createdAt;
    _name = name;
  }

  GetDataCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _image = json['image'] != null ? new Imagess.fromJson(json['image']) : null;
    _selected = false;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
  set selected(bool? value) {
    _selected = value;
  }
}


class Imagess {
  int? id;
  String? modelId;
  String? description;
  String? modelType;
  String? thump;
  String? icon;
  String? url;
  String? createdAt;
  String? updatedAt;

  Imagess(
      {this.id,
        this.modelId,
        this.description,
        this.modelType,
        this.thump,
        this.icon,
        this.url,
        this.createdAt,
        this.updatedAt});

  Imagess.fromJson(Map<String, dynamic> json) {
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
