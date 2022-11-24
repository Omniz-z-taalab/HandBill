// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hand_bill/src/blocs/chat/chat_bloc.dart';
// import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
// import 'package:hand_bill/src/common/constns.dart';
// import 'package:hand_bill/src/data/model/chats/conversation.dart';
// import 'package:hand_bill/src/data/model/chats/conversition_model.dart';
// import 'package:hand_bill/src/data/model/local/chat_user.dart';
// import 'package:hand_bill/src/data/model/user.dart';
// import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
// import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
// import 'package:hand_bill/src/ui/screens/account_package/chat/component/conversaition_empty_widget.dart';
//
// import 'component/conversation_widget.dart';
//
// class ChatsScreen extends StatefulWidget {
//   static const routeName = "/chatsScreen";
//
//   @override
//   _ChatsScreenState createState() => _ChatsScreenState();
// }
//
// class _ChatsScreenState extends State<ChatsScreen> {
//   User? _user;
//   late ChatBloc _chatBloc;
//   bool loading = true;
//
//   @override
//   void initState() {
//     _chatBloc = BlocProvider.of<ChatBloc>(context);
//     _user = BlocProvider.of<GlobalBloc>(context).user;
//     getUser();
//
//     super.initState();
//   }
//
//   getUser() async {
//     if (_user != null) {
//       _chatBloc..add(FetchConversationEvent(user: _user!));
//
//       FirebaseFirestore.instance
//           .collection("conversations")
//           .where("visible_to_users", arrayContains: _user!.id)
//           .get()
//           .then((value) {
//         // log("${jsonEncode(value.docs[0].reference)}");
//         print("vvvvvvv ${value.docs.length}");
//       });
//       setState(() {
//         loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: RegularAppBar(label: "Chats"),
//         body: BlocBuilder<ChatBloc, ChatState>(
//             builder: (BuildContext context, state) {
//           if (state is GetConversationSuccessState) {}
//           return CustomScrollView(
//             slivers: [
//               loading == true
//                   ? CenterWidgetListSliver(
//                       label: "you must register first",
//                       paddingHor: 16,
//                       showLoginBtn: true)
//                   : SliverToBoxAdapter(
//                       child: StreamBuilder(
//                           stream: _chatBloc.conversations,
//                           builder: (BuildContext context,
//                               AsyncSnapshot<QuerySnapshot> snapshot) {
//                             print("ddddd   ${snapshot.data?.size}");
//                             switch (snapshot.connectionState) {
//                               case ConnectionState.waiting:
//                                 return shimmer();
//                               default:
//                                 if (snapshot.data != null) {
//                                   return snapshot.data!.size == 0
//                                       ? Container(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.8,
//                                           child: Center(
//                                               child: Text("No chats yet",
//                                                   style: TextStyle(
//                                                       fontSize: 18,
//                                                       height: 1.5,
//                                                       fontWeight:
//                                                           FontWeight.normal,
//                                                       color: textLiteColor),
//                                                   textAlign: TextAlign.center)))
//                                       : ListView.separated(
//                                           physics: BouncingScrollPhysics(),
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 16),
//                                           // primary: false,
//                                           shrinkWrap: true,
//                                           itemCount: snapshot.data!.size,
//                                           itemBuilder: (context, index) {
//                                             ConversationModel _conversation =
//                                                 ConversationModel.fromJson(
//                                                     snapshot.data!.docs[index]
//                                                         .data());
//                                             log("${_conversation.toJson()}");
//
//                                             // log("${jsonEncode(snapshot.data!.docs[0].data())}");
//                                             return ConversationWidget(
//                                                 model: _conversation,
//                                                 user: ChatUser(id: _user!.id));
//                                           },
//                                           separatorBuilder:
//                                               (BuildContext context,
//                                                       int index) =>
//                                                   SizedBox(height: 16));
//                                 } else {
//                                   return shimmer();
//                                 }
//                             }
//                           }))
//             ],
//           );
//         }));
//   }
//
//   Widget shimmer() {
//     return ListView.separated(
//         primary: false,
//         shrinkWrap: true,
//         padding: EdgeInsets.symmetric(vertical: 16),
//         itemCount: 4,
//         itemBuilder: (context, index) => ConversationEmptyWidget(),
//         separatorBuilder: (BuildContext context, int index) =>
//             SizedBox(height: 16));
//   }
// }
