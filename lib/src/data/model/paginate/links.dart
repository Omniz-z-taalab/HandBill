class Links {
  String? _first;
  String? _last;
  dynamic? _prev;
  dynamic? _next;

  String? get first => _first;
  String? get last => _last;
  dynamic? get prev => _prev;
  dynamic? get next => _next;

  Links({
    String? first,
    String? last,
    dynamic? prev,
    dynamic? next}){
    _first = first;
    _last = last;
    _prev = prev;
    _next = next;
  }

  Links.fromJson(dynamic json) {
    _first = json["first"];
    _last = json["last"];
    _prev = json["prev"];
    _next = json["next"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first"] = _first;
    map["last"] = _last;
    map["prev"] = _prev;
    map["next"] = _next;
    return map;
  }

}