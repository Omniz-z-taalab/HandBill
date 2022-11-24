import 'links.dart';

class Meta {
  dynamic? _currentPage;
  dynamic? _from;
  dynamic? _lastPage;
  List<Links>? _links;
  dynamic? _path;
  dynamic? _perPage;
  dynamic? _to;
  dynamic? _total;

  dynamic? get currentPage => _currentPage;
  dynamic? get from => _from;
  dynamic? get lastPage => _lastPage;
  List<Links>? get links => _links;
  dynamic? get path => _path;
  dynamic? get perPage => _perPage;
  dynamic? get to => _to;
  dynamic? get total => _total;

  Meta({
    dynamic? currentPage,
    dynamic? from,
    dynamic? lastPage,
    List<Links>? links,
    dynamic? path,
    dynamic? perPage,
    dynamic? to,
    dynamic? total}){
    _currentPage = currentPage;
    _from = from;
    _lastPage = lastPage;
    _links = links;
    _path = path;
    _perPage = perPage;
    _to = to;
    _total = total;
  }

  Meta.fromJson(dynamic json) {
    _currentPage = json["current_page"];
    _from = json["from"];
    _lastPage = json["last_page"];
    if (json["links"] != null) {
      _links = [];
      json["links"].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _path = json["path"];
    _perPage = json["per_page"];
    _to = json["to"];
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = _currentPage;
    map["from"] = _from;
    map["last_page"] = _lastPage;
    if (_links != null) {
      map["links"] = _links?.map((v) => v.toJson()).toList();
    }
    map["path"] = _path;
    map["per_page"] = _perPage;
    map["to"] = _to;
    map["total"] = _total;
    return map;
  }

}