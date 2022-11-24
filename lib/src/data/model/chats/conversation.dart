import 'package:flutter/material.dart';
import 'package:hand_bill/src/data/model/local/chat_user.dart';
import 'package:hand_bill/src/data/model/user.dart';

class Conversation {
  String? id;

  // conversation name for example chat with restaurant name
  String? name;

  // Chats messages
  String? lastMessage;

  int? lastMessageTime;

  // Ids of users that read the chat message
  List<String?>? readByUsers;

  // Ids of users in this conversation
  List<String?>? visibleToUsers;

  // users in the conversation
  List<ChatUser>? users;

  Conversation(this.users, {this.id = null, this.name = ''}) {
    visibleToUsers = this.users!.map((user) => user.id.toString()).toList();
    readByUsers = [];
  }

  Conversation.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : null;
      name = jsonMap['name'] != null ? jsonMap['name'].toString() : '';
      readByUsers = jsonMap['read_by_users'] != null
          ? List.from(jsonMap['read_by_users'])
          : [];
      visibleToUsers = jsonMap['visible_to_users'] != null
          ? List.from(jsonMap['visible_to_users'])
          : [];
      lastMessage =
          jsonMap['message'] != null ? jsonMap['message'].toString() : '';
      lastMessageTime = jsonMap['time'] != null ? jsonMap['time'] : 0;
      users = jsonMap['users'] != null
          ? List.from(jsonMap['users']).map((element) {
              element['media'] = [
                {'thumb': element['thumb']}
              ];
              return ChatUser.fromJson(element);
            }).toList()
          : [];
    } catch (e) {
      id = '';
      name = '';
      readByUsers = [];
      users = [];
      lastMessage = '';
      lastMessageTime = 0;
    }
  }

  Conversation.fromData(dynamic json) {
    try {
      id = json['id'] != null ? json['id'].toString() : null;
      name = json['name'] != null ? json['name'].toString() : '';
      readByUsers =
          json['read_by_users'] != null ? List.from(json['read_by_users']) : [];
      visibleToUsers = json['visible_to_users'] != null
          ? List.from(json['visible_to_users'])
          : [];
      lastMessage = json['message'] != null ? json['message'].toString() : '';
      lastMessageTime = json['time'] != null ? json['time'] : 0;

      if (json["users"] != null) {
        users = [];
        json["users"].forEach((v) {
          users?.add(ChatUser.fromJson(v));
        });
      }
      // users = json['users'] != null
      //     ? List.from(json['users']).map((element) {
      //         element['media'] = [
      //           {'thumb': element['thumb']}
      //         ];
      //         return ChatUser.fromJson(element);
      //       }).toList()
      //     : [];
    } catch (e) {
      id = '';
      name = '';
      readByUsers = [];
      users = [];
      lastMessage = '';
      lastMessageTime = 0;
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["users"] =
        users!.map((element) => element.toRestrictMap()).toSet().toList();
    map["visible_to_users"] =
        users!.map((element) => element.id).toSet().toList();
    map["read_by_users"] = readByUsers;
    map["message"] = lastMessage;
    map["time"] = lastMessageTime;
    return map;
  }

  Map toUpdatedMap() {
    var map = new Map<String, dynamic>();
    map["message"] = lastMessage;
    map["time"] = lastMessageTime;
    map["read_by_users"] = readByUsers;
    // map["users"] =
    //     users!.map((element) => element.toRestrictMap()).toSet().toList();
    return map;
  }

  Map toDeletedMap({required User? user}) {
    var map = new Map<String, dynamic>();
    users!.removeWhere((_user) => _user.id == user!.id);
    map["visible_to_users"] =
        users!.map((element) => element.id).toSet().toList();
    return map;
  }
}
