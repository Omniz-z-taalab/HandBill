// class ServiceCategoryModel {
//   List<Data>? data;
//   bool? status;
//   String? message;
//
//   ServiceCategoryModel({this.data, this.status, this.message});
//
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
//
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
//
//   Data(
//       {this.id,
//       this.name,
//       this.description,
//       this.createdAt,
//       this.updatedAt,
//       this.deletedAt,
//       this.image});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//     image = json['image'];
//   }
//
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
