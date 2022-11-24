// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hand_bill/src/blocs/chat/chat_bloc.dart';
// import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
// import 'package:hand_bill/src/common/constns.dart';
// import 'package:hand_bill/src/data/model/chats/chat.dart';
// import 'package:hand_bill/src/data/model/chats/conversation.dart';
// import 'package:hand_bill/src/data/model/chats/conversition_model.dart';
// import 'package:hand_bill/src/data/model/local/chat_user.dart';
// import 'package:hand_bill/src/data/model/local/route_argument.dart';
// import 'package:hand_bill/src/data/model/user.dart';
// import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
//
// import 'component/message_empty_widget.dart';
// import 'component/message_widget.dart';
//
// class InboxScreen extends StatefulWidget {
//   static const routeName = "/InboxScreen";
//
//   RouteArgument routeArgument;
//
//   InboxScreen({required this.routeArgument});
//
//   @override
//   _InboxScreenState createState() => _InboxScreenState();
// }
//
// class _InboxScreenState extends State<InboxScreen> {
//   final _messageController = TextEditingController();
//
//   Color bgColor = Color(0xffF9F9F9);
//   Color borderColor = Color(0x80e4e4e4);
//   Color hintColor = Color(0xccb3b3b3);
//   double radius = 900;
//   final _myListKey = GlobalKey<AnimatedListState>();
//   bool loading = true;
//
//   String _companyName = "";
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   late ChatBloc _chatBloc;
//   late User _user;
//   late ChatUser _chatUser;
//   late ConversationModel _conversation;
//
//   @override
//   void initState() {
//     _user = BlocProvider.of<GlobalBloc>(context).user!;
//     _conversation = widget.routeArgument.param;
//     _chatBloc = BlocProvider.of<ChatBloc>(context);
//     // _user = _conversation.users!;
//     _chatUser = ChatUser(
//         id: _user.id,
//         name: _user.name,
//         email: _user.email,
//         deviceToken: _user.deviceToken,
//         thumb: placeholder);
//     getChats();
//     super.initState();
//   }
//
//   getChats() {
//     WidgetsBinding.instance!.addPostFrameCallback((_) async {
//
//       setState(() {
//         _chatBloc.conversation = _conversation;
//         _conversation.users!.forEach((element) {
//           if (element.id != _user.id) {
//             _companyName = element.name!;
//           }
//         });
//         // _companyName = _conversation.company!.name ?? "";
//         loading = false;
//       });
//
//       // from chats
//       if (_chatBloc.conversation!.id != null) {
//         _chatBloc
//           ..add(FetchChatsEvent(
//               conversation: _chatBloc.conversation, user: _chatUser));
//       } else {
//         // from company
//         _conversation.users!.forEach((element) {
//           if (element.id != _user.id) {
//             _firestore
//                 .collection("conversations")
//                 .where("visible_to_users", arrayContains: element.id)
//                 .get()
//                 .then((value) {
//               if (value.size > 0) {
//                 setState(() {
//                   Map<String, dynamic> map = value.docs[0].data();
//                   _chatBloc.conversation = ConversationModel.fromJson(map);
//                   _chatBloc.add(FetchChatsEvent(
//                       conversation: _chatBloc.conversation, user: _chatUser));
//                 });
//               }
//             });
//           }
//         });
//
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   Color mainColor = Color(0xfffafafa);
//   Color fillColor = Color(0xffffffff);
//   Color iconColor = Color(0xff000000);
//
//   @override
//   Widget build(BuildContext context) {
//     _onSubmitted() async {
//       if (_messageController.text.length >= 1 && _conversation != null) {
//         _chatBloc.add(AddMessageEvent(
//             conversation: _chatBloc.conversation,
//             text: _messageController.text,
//             user: _chatUser));
//         if (_chatBloc.conversation!.id != null) {
//           _chatBloc
//             ..add(FetchChatsEvent(
//                 conversation: _chatBloc.conversation, user: _chatUser));
//         }
//         _messageController.clear();
//       }
//     }
//     return Scaffold(
//         appBar: RegularAppBar(label: _companyName),
//         backgroundColor: Color(0xfff5f5f5),
//         body: BlocBuilder<ChatBloc, ChatState>(
//             builder: (BuildContext context, state) {
//           if (state is GetChatsSuccessState) {}
//           return NotificationListener<OverscrollIndicatorNotification>(
//               onNotification: (overScroll) {
//                 overScroll.disallowGlow();
//                 return true;
//               },
//               child: CustomScrollView(
//                   shrinkWrap: true,
//                   primary: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   slivers: [
//                     SliverFillRemaining(
//                         child: Column(children: [
//                       loading == true
//                           ? shimmer()
//                           : Expanded(
//                               child: StreamBuilder(
//                                   stream: _chatBloc.chats,
//                                   builder: (BuildContext context,
//                                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                                     switch (snapshot.connectionState) {
//                                       case ConnectionState.waiting:
//                                       // return shimmer();
//                                       default:
//                                         if (snapshot.data != null) {
//                                           return ListView.separated(
//                                               key: _myListKey,
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: 16),
//                                               reverse: true,
//                                               physics: BouncingScrollPhysics(),
//                                               shrinkWrap: true,
//                                               itemCount: snapshot.data!.size,
//                                               itemBuilder: (context, index) {
//                                                 Chat chat = Chat.fromData(
//                                                     snapshot.data!.docs[index]
//                                                         .data());
//                                                 chat.user = _chatUser;
//
//                                                 return MessageWidget(
//                                                     model: chat, user: _user);
//                                               },
//                                               separatorBuilder:
//                                                   (BuildContext context,
//                                                           int index) =>
//                                                       SizedBox(height: 16));
//                                         } else {
//                                           return Container();
//                                         }
//                                     }
//                                   })),
//                       Container(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 12),
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 24, vertical: 4),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(900),
//                               color: fillColor,
//                               border: Border.all(color: Color(0xffeeeeee))),
//                           child: Row(mainAxisSize: MainAxisSize.min, children: [
//                             InkWell(
//                                 onTap: () {
//                                   // if (valid != true) _onSubmitted();
//                                 },
//                                 child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 0, vertical: 8),
//                                     child: Icon(Icons.emoji_emotions_outlined,
//                                         color: iconColor))),
//                             Expanded(
//                                 child: Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 12),
//                                     child: TextField(
//                                         textAlignVertical:
//                                             TextAlignVertical.top,
//                                         textAlign: TextAlign.start,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .headline1,
//                                         decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.all(0),
//                                             hintText: "write a message",
//                                             filled: true,
//                                             focusColor: mainColor,
//                                             hintStyle: TextStyle(
//                                                 color: iconColor, fontSize: 16),
//                                             fillColor: Colors.transparent,
//                                             enabledBorder: InputBorder.none,
//                                             focusedBorder: InputBorder.none),
//                                         controller: _messageController,
//                                         onSubmitted: (value) =>
//                                             _onSubmitted()))),
//                             IconButton(
//                                 onPressed: () => _onSubmitted(),
//                                 icon: Icon(Icons.send, color: iconColor))
//                           ])),
//                     ]))
//                   ]));
//         }));
//   }
//
//   Widget shimmer() {
//     return ListView.separated(
//         padding: EdgeInsets.symmetric(vertical: 16),
//         primary: false,
//         shrinkWrap: true,
//         itemCount: 4,
//         itemBuilder: (context, index) => MessageEmptyWidget(),
//         separatorBuilder: (BuildContext context, int index) =>
//             SizedBox(height: 16));
//   }
// }
