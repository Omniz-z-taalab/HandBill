import 'package:hand_bill/src/data/model/services/job_category_model.dart';
import 'package:hand_bill/src/data/model/user.dart';

class JobUserModel {
  int? _id;
  String? _subCategoryId;
  String? _categoryId;
  String? _userId;
  String? _description;
  String? _title;

  DateTime? _dateTime;
  String? _updatedAt;
  User? _user;
  JobCategoryModel? _jobCategoryModel;
  JobCategoryModel? _jobSubCategoryModel;

  int? get id => _id;

  String? get subCategoryId => _subCategoryId;

  String? get categoryId => _categoryId;

  String? get userId => _userId;

  String? get description => _description;

  String? get title => _title;

  // String? get createdAt => _dateTime;
  DateTime? get dateTime => _dateTime;

  String? get updatedAt => _updatedAt;

  User? get user => _user;

  JobCategoryModel? get jobCategoryModel => _jobCategoryModel;

  JobCategoryModel? get jobSubCategoryModel => _jobSubCategoryModel;

  JobUserModel(
      {int? id,
      String? subCategoryId,
      String? categoryId,
      String? userId,
      String? description,
      String? title,
      // String? createdAt,
      DateTime? dateTime,
      String? updatedAt,
      User? user,
      JobCategoryModel? jobCategoryModel,
      JobCategoryModel? jobSubCategoryModel}) {
    _id = id;
    _subCategoryId = subCategoryId;
    _categoryId = categoryId;
    _userId = userId;
    _description = description;
    _title = title;
    _dateTime = dateTime;
    _updatedAt = updatedAt;
    _user = user;
    _jobCategoryModel = jobCategoryModel;
    _jobSubCategoryModel = jobSubCategoryModel;
  }

  JobUserModel.fromJson(dynamic json) {
    _id = json["id"];
    _subCategoryId = json["sub_category_id"];
    _categoryId = json["category_id"];
    _userId = json["user_id"];
    _description = json["description"];
    _title = json["title"];
    _dateTime = DateTime.parse(json['created_at']);
    // _dateTime = json["created_at"];
    _updatedAt = json["updated_at"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["sub_category_id"] = _subCategoryId;
    map["category_id"] = _categoryId;
    map["user_id"] = _userId;
    map["description"] = _description;
    map["title"] = _title;
    map["created_at"] = _dateTime;
    map["updated_at"] = _updatedAt;
    if (_user != null) {
      map["user"] = _user?.toJson();
    }
    return map;
  }

  set jobSubCategoryModel(JobCategoryModel? value) {
    _jobSubCategoryModel = value;
  }

  set jobCategoryModel(JobCategoryModel? value) {
    _jobCategoryModel = value;
  }

  set title(String? value) {
    _title = value;
  }

  set description(String? value) {
    _description = value;
  }
}

// class JobModel {
//   int? _id;
//   String? _description;
//   String? _title;
//   String? _userId;
//   String? _createdAt;
//   User? _user;
//
//   int? get id => _id;
//   String? get description => _description;
//   String? get title => _title;
//   String? get userId => _userId;
//   String? get createdAt => _createdAt;
//   User? get user => _user;
//
//   JobModel({
//     int? id,
//     String? description,
//     String? title,
//     String? userId,
//     String? createdAt,
//     User? user}){
//     _id = id;
//     _description = description;
//     _title = title;
//     _userId = userId;
//     _createdAt = createdAt;
//     _user = user;
//   }
//
//   JobModel.fromJson(dynamic json) {
//     _id = json["id"];
//     _description = json["description"];
//     _title = json["title"];
//     _userId = json["user_id"];
//     _createdAt = json["created_at"];
//     _user = json["user"] != null ? User.fromJson(json["user"]) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["description"] = _description;
//     map["title"] = _title;
//     map["user_id"] = _userId;
//     map["created_at"] = _createdAt;
//     if (_user != null) {
//       map["user"] = _user?.toJson();
//     }
//     return map;
//   }
//
// }
