import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/notification_model.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitialState extends NotificationsState {}

class NotificationsLoadingState extends NotificationsState {}

class NotificationsErrorState extends NotificationsState {
  final String? error;

  NotificationsErrorState({required this.error});
}

// fetch
class NotificationsSuccessState extends NotificationsState {
  final List<NotificationModel>? items;

  NotificationsSuccessState({required this.items});
}

// remove

class ChangeReadNotificationsSuccessState extends NotificationsState {
  final String? message;
  final NotificationModel? model;

  ChangeReadNotificationsSuccessState(
      {required this.message, required this.model});
}

// remove

class RemoveFromNotificationsSuccessState extends NotificationsState {
  final String? message;
  final NotificationModel? model;

  RemoveFromNotificationsSuccessState(
      {required this.message, required this.model});
}
