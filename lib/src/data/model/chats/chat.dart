import 'package:flutter/material.dart';
import 'package:hand_bill/src/data/model/local/chat_user.dart';
import 'package:hand_bill/src/data/model/user.dart';

class Chat {
  String? id = UniqueKey().toString();

  // message text
  String? text;

  // time of the message
  int? time;

  // user id who send the message
  int? userId;

  // User? user;
  ChatUser? user;

  Chat(this.text, this.time, this.userId);

  Chat.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : null;
      text = jsonMap['text'] != null ? jsonMap['text'].toString() : '';
      time = jsonMap['time'] != null ? jsonMap['time'] : 0;
      userId = jsonMap['user'] != null ? jsonMap['user'] : null;
    } catch (e) {
      id = null;
      text = '';
      time = 0;
      user = null;
      userId = null;
      print(e);
    }
  }

  Chat.fromData(dynamic json) {
    try {
      id = json['id'] != null ? json['id'].toString() : null;
      text = json['text'] != null ? json['text'].toString() : '';
      time = json['time'] != null ? json['time'] : 0;
      userId = json['user'] != null ? json['user'] : null;
    } catch (e) {
      id = null;
      text = '';
      time = 0;
      user = null;
      userId = null;
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["text"] = text;
    map["time"] = time;
    map["user"] = userId;
    return map;
  }
}
