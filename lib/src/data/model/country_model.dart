class CountryModel {
  int? _id;
  String? _name;
  String? _alpha2;
  String? _alpha3;

  int? get id => _id;
  String? get name => _name;
  String? get alpha2 => _alpha2;
  String? get alpha3 => _alpha3;

  CountryModel({
    int? id,
    String? name,
    String? alpha2,
    String? alpha3}){
    _id = id;
    _name = name;
    _alpha2 = alpha2;
    _alpha3 = alpha3;
  }

  CountryModel.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _alpha2 = json["alpha2"];
    _alpha3 = json["alpha3"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["alpha2"] = _alpha2;
    map["alpha3"] = _alpha3;
    return map;
  }

  set name(String? value) {
    _name = value;
  }
}