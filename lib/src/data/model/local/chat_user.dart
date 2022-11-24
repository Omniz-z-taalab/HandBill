class ChatUser {
  String? _thumb;
  String? _deviceToken;
  String? _name;
  int? _id;
  String? _email;

  String? get thumb => _thumb;
  String? get deviceToken => _deviceToken;
  String? get name => _name;
  int? get id => _id;
  String? get email => _email;

  ChatUser({
    String? thumb,
    String? deviceToken,
    String? name,
    int? id,
    String? email}){
    _thumb = thumb;
    _deviceToken = deviceToken;
    _name = name;
    _id = id;
    _email = email;
  }

  ChatUser.fromJson(dynamic json) {
    _thumb = json["thumb"];
    _deviceToken = json["device_token"];
    _name = json["name"];
    _id = json["id"];
    _email = json["email"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["thumb"] = _thumb;
    map["device_token"] = _deviceToken;
    map["name"] = _name;
    map["id"] = _id;
    map["email"] = _email;
    return map;
  }
  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["email"] = _email;
    map["name"] = _name;
    // map["thumb"] = image;
    map["device_token"] = _deviceToken;
    return map;
  }

}