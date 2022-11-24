import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/services/job_category_model.dart';

class JobCompanyModel {
  int? _id;
  String? _subCategoryId;
  String? _categoryId;
  String? _companyId;
  String? _description;
  String? _title;

  DateTime? _dateTime;
  String? _updatedAt;
  Company? _company;
  JobCategoryModel? _jobCategoryModel;
  JobCategoryModel? _jobSubCategoryModel;

  int? get id => _id;

  String? get subCategoryId => _subCategoryId;

  String? get categoryId => _categoryId;

  String? get companyId => _companyId;

  String? get description => _description;

  String? get title => _title;

  // String? get createdAt => _dateTime;
  DateTime? get dateTime => _dateTime;

  String? get updatedAt => _updatedAt;

  Company? get company => _company;

  JobCategoryModel? get jobCategoryModel => _jobCategoryModel;

  JobCategoryModel? get jobSubCategoryModel => _jobSubCategoryModel;

  JobCompanyModel(
      {int? id,
      String? subCategoryId,
      String? categoryId,
      String? companyId,
      String? description,
      String? title,
      // String? createdAt,
      DateTime? dateTime,
      String? updatedAt,
      Company? company,
      JobCategoryModel? jobCategoryModel,
      JobCategoryModel? jobSubCategoryModel}) {
    _id = id;
    _subCategoryId = subCategoryId;
    _categoryId = categoryId;
    _companyId = companyId;
    _description = description;
    _title = title;
    _dateTime = dateTime;
    _updatedAt = updatedAt;
    _company = company;
    _jobCategoryModel = jobCategoryModel;
    _jobSubCategoryModel = jobSubCategoryModel;
  }

  JobCompanyModel.fromJson(dynamic json) {
    _id = json["id"];
    _subCategoryId = json["sub_category_id"];
    _categoryId = json["category_id"];
    _companyId = json["company_id"];
    _description = json["description"];
    _title = json["title"];
    _dateTime = DateTime.parse(json['created_at']);
    // _dateTime = json["created_at"];
    _updatedAt = json["updated_at"];
    _company = json["company"] != null ? Company.fromJson(json["company"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["sub_category_id"] = _subCategoryId;
    map["category_id"] = _categoryId;
    map["company_id"] = _companyId;
    map["description"] = _description;
    map["title"] = _title;
    map["created_at"] = _dateTime;
    map["updated_at"] = _updatedAt;
    if (_company != null) {
      map["company"] = _company?.toJson();
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
