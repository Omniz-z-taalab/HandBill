import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/data/model/chats/chat.dart';
import 'package:hand_bill/src/data/model/chats/conversition_model.dart';
import 'package:hand_bill/src/data/model/local/chat_user.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/repositories/chat_ropository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  // ChatRepository chatRepository = ChatRepository();
  //
  ChatBloc() : super(ChatInitial());
  // ConversationModel? conversation;
  // Stream<QuerySnapshot>? chats;
  // Stream<QuerySnapshot>? conversations;
  //
  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    // if (event is FetchConversationEvent) {
    //   yield* _mapGetConversations(event);
    // }
    //
    // if (event is FetchChatsEvent) {
    //   yield* _mapGetChats(event);
    // }
    //
    // if (event is AddMessageEvent) {
    //   yield* _mapAddMessage(event);
    // }
  }
  //
  // Stream<ChatState> _mapGetConversations(FetchConversationEvent event) async* {
  //   chatRepository.getUserConversions(event.user).then((_conversations) {
  //     conversations = _conversations;
  //   });
  //   yield GetConversationSuccessState(conversation: conversations);
  // }
  //
  // Stream<ChatState> _mapGetChats(FetchChatsEvent event) async* {
  //   // event.conversation!.readByUsers!.add(event.user!.id);
  //   chatRepository.getChats(event.conversation!).then((_chats) {
  //     chats = _chats;
  //   });
  // }
  //
  // // Stream<ChatState> _mapAddMessage(AddMessageEvent event) async* {
  // //   Conversation _conversation = event.conversation!;
  // //   Chat _chat = new Chat(event.text,
  // //       DateTime.now().toUtc().millisecondsSinceEpoch, event.user!.id);
  // //   if (_conversation.id == null) {
  // //     _conversation.id = UniqueKey().toString();
  // //     createConversation(_conversation, event.user!);
  // //   }
  // //   _conversation.lastMessage = event.text;
  // //   _conversation.lastMessageTime = _chat.time;
  // //   // _conversation.readByUsers = [event.user!.id];
  // //
  // //   bool send = await chatRepository.addMessage(
  // //       conversation: _conversation, chat: _chat);
  // //
  // //   log("cccc ${_conversation.user!.name}");
  // //   if (send) {
  // //     yield AddMessageSuccessState();
  // //     chatRepository.sendFcmMessage(
  // //         body: event.text,
  // //         title: "Message from" + " " + _conversation.user!.name!,
  // //         company: _conversation.company!);
  // //
  // //     print("sendddddd");
  // //   } else {
  // //     print("faillllllll");
  // //   }
  // // }
  //
  // Stream<ChatState> _mapAddMessage(AddMessageEvent event) async* {
  //   ConversationModel _conversation = event.conversation!;
  //   Chat _chat = new Chat(event.text,
  //       DateTime.now().toUtc().millisecondsSinceEpoch, event.user!.id);
  //   if (_conversation.id == null) {
  //     _conversation.id = UniqueKey().toString();
  //     createConversation(_conversation, event.user!);
  //   }
  //   _conversation.message = event.text;
  //   _conversation.time = _chat.time;
  //   _conversation.readByUsers = [event.user!.id.toString()];
  //   // _conversation.users!.forEach((element) {
  //   //   if (element.id == event.user!.id) {
  //   //     print("${element.toJson()}");
  //   //     element = event.user!;
  //   //   }
  //   // });
  //   bool send = await chatRepository.addMessage(
  //       conversation: _conversation, chat: _chat);
  //   if (send) {
  //     yield AddMessageSuccessState();
  //     _conversation.users!.forEach((_user) {
  //       if (_user.id != event.user!.id) {
  //         chatRepository.sendFcmMessage(
  //             body: event.text,
  //             title: "message from" + " " + event.user!.name!,
  //             chatUser:  _user);
  //       }
  //     });
  //   } else {
  //     print("faillllllll");
  //   }
  // }
  //
  // createConversation(ConversationModel _conversation, ChatUser user) async {
  //   // _conversation.users!.insert(0, user);
  //   _conversation.time =
  //       DateTime.now().toUtc().millisecondsSinceEpoch;
  //   _conversation.readByUsers = [user.id.toString()];
  //   conversation = _conversation;
  //   await chatRepository.createConversation(conversation!).then((value) {
  //     add(FetchChatsEvent(conversation: conversation, user: user));
  //   });
  // }
  //
  // orderSnapshotByTime(AsyncSnapshot snapshot) {
  //   final docs = snapshot.data.documents;
  //   // docs.sort((QueryDocumentSnapshot a, QueryDocumentSnapshot b) {
  //   //   var time1 = a.get('time');
  //   //   var time2 = b.get('time');
  //   //   return time2.compareTo(time1) as int?;
  //   // });
  //   return docs;
  // }
}
