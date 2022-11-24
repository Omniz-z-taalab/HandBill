part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class FetchConversationEvent extends ChatEvent {
  final User user;

  FetchConversationEvent({required this.user});
}

class FetchChatsEvent extends ChatEvent {
  final ConversationModel? conversation;
  final ChatUser? user;

  FetchChatsEvent({required this.conversation, required this.user});
}

class AddMessageEvent extends ChatEvent {
  final ConversationModel? conversation;
  final String? text;
  final ChatUser? user;
  // final Company? company;

  AddMessageEvent({this.conversation, this.user, this.text});
}
