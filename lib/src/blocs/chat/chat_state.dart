part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class GetConversationSuccessState extends ChatState {
  // final Stream<QuerySnapshot>? conversation;
  //
  // GetConversationSuccessState({required this.conversation});

  // @override
  // List<Object> get props => [conversation];
}

class GetChatsSuccessState extends ChatState {
  // final Stream<QuerySnapshot> chats;
  //
  // GetChatsSuccessState({required this.chats});

  // @override
  // List<Object> get props => [chats];
}

class AddMessageSuccessState extends ChatState {}
