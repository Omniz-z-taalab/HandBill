import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/paginate/links.dart';
import 'package:hand_bill/src/data/model/paginate/meta.dart';

class SearchCompaniesResponse {
  List<Company>? _data;
  Links? _links;
  Meta? _meta;

  List<Company>? get data => _data;

  Links? get links => _links;

  Meta? get meta => _meta;

  SearchCompaniesResponse(
      {List<Company>? data, bool? status, String? message}) {
    _data = data;
    _links = links;
    _meta = meta;
  }

  SearchCompaniesResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(Company.fromJson(v));
      });
    }
    _links = json["links"] != null ? Links.fromJson(json["links"]) : null;
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data!.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map["links"] = _links!.toJson();
    }
    if (_meta != null) {
      map["meta"] = _meta!.toJson();
    }
    return map;
  }
}

