import 'package:hand_bill/src/data/model/search_Subcategoreis_model.dart';

class SearchSubSubCategoriesResponse {
  List<Categories>? data;
  bool? status;
  String? message;

  SearchSubSubCategoriesResponse({this.data, this.status, this.message});

  SearchSubSubCategoriesResponse.fromJson(Map<String, dynamic> json) {
  if (json['data'] != null) {
  data = <Categories>[];
  json['data'].forEach((v) {
  data!.add(new Categories.fromJson(v));
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