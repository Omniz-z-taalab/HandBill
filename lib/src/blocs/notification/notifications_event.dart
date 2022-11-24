import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/data/model/notification_model.dart';

abstract class NotificationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch
class NotificationsFetchEvent extends NotificationsEvent {}

// change
class ChangeReadNotificationEvent extends NotificationsEvent {
  final NotificationModel? model;
  ChangeReadNotificationEvent({required this.model});
}

// remove
class RemoveFromNotificationsButtonPressedEvent extends NotificationsEvent {
  final NotificationModel? model;

  RemoveFromNotificationsButtonPressedEvent({
    required this.model,
  });

  @override
  List<Object?> get props => [model];
}
