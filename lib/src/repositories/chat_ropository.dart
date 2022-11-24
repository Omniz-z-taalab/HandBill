// import 'dart:async';
// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:hand_bill/src/common/constns.dart';
// import 'package:hand_bill/src/data/model/chats/chat.dart';
// import 'package:hand_bill/src/data/model/chats/conversition_model.dart';
// import 'package:hand_bill/src/data/model/local/chat_user.dart';
// import 'package:http/http.dart' as http;
// import 'package:hand_bill/src/data/model/user.dart' as user;
//
// class ChatRepository {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   static FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//
//   Future signInWithToken(String token) async {
//     try {
//       UserCredential result = await _auth.signInWithCustomToken(token);
//       if (result.user != null) {
//         return true;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
//
//   Future signInWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       if (result.user != null) {
//         return true;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
//
//   Future signOut(String token) async {
//     try {
//       return await _auth.signOut();
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
//
//   Future<void> addUserInfo(userData) async {
//     FirebaseFirestore.instance
//         .collection("users")
//         .add(userData)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }
//
//   getUserInfo(String token) async {
//     return FirebaseFirestore.instance
//         .collection("users")
//         .where("token", isEqualTo: token)
//         .get()
//         .catchError((e) {
//       print(e);
//     });
//   }
//
//   searchByName(String searchByField) async {
//     return FirebaseFirestore.instance
//         .collection("users")
//         .where("userName", isEqualTo: searchByField)
//         .get()
//         .catchError((e) {
//       print(e);
//     });
//   }
//
//   Future<void> createConversation(ConversationModel conversation) async {
//     await _fireStore
//         .collection("conversations")
//         .doc(conversation.id)
//         .set(conversation.toJson())
//         .catchError((e) {
//       print(e.toString());
//     });
//   }
//
//   Future<Stream<QuerySnapshot>> getChats(ConversationModel conversation) async {
//     return _fireStore
//         .collection("conversations")
//         .doc(conversation.id)
//         .collection("chats")
//         .orderBy('time', descending: true)
//         .snapshots();
//   }
//
//   Future<Stream<QuerySnapshot>> getUserConversions(user.User user) async {
//     return _fireStore
//         .collection("conversations")
//         .where("visible_to_users", arrayContains: user.id)
//         .snapshots();
//   }
//
//   Future<bool> addMessage(
//       {required ConversationModel conversation, required Chat chat}) async {
//     bool send = false;
//     await _fireStore
//         .collection("conversations")
//         .doc(conversation.id)
//         .collection("chats")
//         .add(chat.toMap() as Map<String, dynamic>)
//         .whenComplete(() {
//       updateConversation(
//           conversationId: conversation.id,
//           conversation: conversation.toUpdatedMap() as Map<String, dynamic>);
//       send = true;
//     }).catchError((e) {
//       send = false;
//       print("\naddMessageError: ${e.toString()}");
//     });
//
//     return send;
//   }
//
//   Future<bool> sendFcmMessage(
//       {String? title, String? body, required ChatUser chatUser}) async {
//     try {
//       var url = 'https://fcm.googleapis.com/fcm/send';
//       var header = {
//         "Content-Type": "application/json",
//         "Authorization": "key=$fcmKey",
//       };
//       var request = {
//         'notification': {'title': title, 'body': body},
//         "priority": "high",
//         'data': {
//           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//           'type': 'COMMENT',
//           "status": "done"
//         },
//         'to': '${chatUser.deviceToken}'
//       };
//
//       var client = new http.Client();
//       var response = await client.post(Uri.parse(url),
//           headers: header, body: json.encode(request));
//       if (response.statusCode != 200) {
//         print('notification sending failed');
//       } else {
//         // Fluttertoast.showToast(msg: "send");
//       }
//       return true;
//     } catch (e, s) {
//       print("$e  -  $s");
//       return false;
//     }
//   }
//
//   updateConversation(
//       {String? conversationId, required Map<String, dynamic> conversation}) {
//     return _fireStore
//         .collection("conversations")
//         .doc(conversationId)
//         .update(conversation)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }
// }
