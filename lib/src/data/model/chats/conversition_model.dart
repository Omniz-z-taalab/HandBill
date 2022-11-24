import 'package:hand_bill/src/data/model/local/chat_user.dart';

class ConversationModel {
  List<int>? _visibleToUsers;
  String? _name;
  String? _id;
  int? _time;
  String? _message;
  List<String>? _readByUsers;
  List<ChatUser>? _users;

  List<int>? get visibleToUsers => _visibleToUsers;

  String? get name => _name;

  String? get id => _id;

  int? get time => _time;

  String? get message => _message;

  List<String>? get readByUsers => _readByUsers;

  List<ChatUser>? get users => _users;

  ConversationModel(
      {List<int>? visibleToUsers,
      String? name,
      String? id,
      int? time,
      String? message,
      List<String>? readByUsers,
      List<ChatUser>? users}) {
    _visibleToUsers = visibleToUsers;
    _name = name;
    _id = id;
    _time = time;
    _message = message;
    _readByUsers = readByUsers;
    _users = users;
  }

  ConversationModel.fromJson(dynamic json) {
    _visibleToUsers = json["visible_to_users"] != null
        ? json["visible_to_users"].cast<int>()
        : [];
    _name = json["name"];
    _id = json["id"];
    _time = json["time"];
    _message = json["message"];
    _readByUsers = json["read_by_users"] != null
        ? json["read_by_users"].cast<String>()
        : [];
    if (json["users"] != null) {
      _users = [];
      json["users"].forEach((v) {
        _users?.add(ChatUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["visible_to_users"] =
        users!.map((element) => element.id).toSet().toList();
    map["name"] = _name;
    map["id"] = _id;
    map["time"] = _time;
    map["message"] = _message;
    map["read_by_users"] = _readByUsers;
    if (_users != null) {
      map["users"] = _users?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Map toUpdatedMap() {
    var map = new Map<String, dynamic>();
    map["message"] = message;
    map["time"] = time;
    map["read_by_users"] = readByUsers;
    if (_users != null) {
      map["users"] = _users?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set readByUsers(List<String>? value) {
    _readByUsers = value;
  }

  set time(int? value) {
    _time = value;
  }

  set message(String? value) {
    _message = value;
  }

  set id(String? value) {
    _id = value;
  }
}
