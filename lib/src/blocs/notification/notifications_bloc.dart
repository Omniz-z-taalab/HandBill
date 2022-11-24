import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/data/response/general_response.dart';
import 'package:hand_bill/src/repositories/notifications_repository.dart';

import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  String tag = "NotificationsBloc";

  NotificationsRepository notificationsRepository = NotificationsRepository();
  int page = 1;
  bool isFetching = true;

  NotificationsBloc({required BuildContext context})
      : super(NotificationsInitialState()) {
    notificationsRepository.user = BlocProvider.of<GlobalBloc>(context).user;
  }

  @override
  Stream<NotificationsState> mapEventToState(NotificationsEvent event) async* {
    if (event is NotificationsFetchEvent) {
      yield* _mapFetchNotifications();
    }

    if (event is ChangeReadNotificationEvent) {
      yield* _mapChangeReadNotificationsToState(event);
    }

    if (event is RemoveFromNotificationsButtonPressedEvent) {
      yield* _mapRemoveFromNotificationsToState(event);
    }
  }

  Stream<NotificationsState> _mapFetchNotifications() async* {
    yield NotificationsLoadingState();
    final response =
        await notificationsRepository.getNotificationsData(page: page);

    if (response.status!) {
      final items = response.data;
      yield NotificationsSuccessState(items: items);
      page++;
      isFetching = false;
    } else {
      yield NotificationsErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<NotificationsState> _mapChangeReadNotificationsToState(
      ChangeReadNotificationEvent event) async* {
    yield NotificationsLoadingState();

    GeneralResponse response =
        await notificationsRepository.markReadNotifiactions(event.model!);
    try {
      if (response.status!) {
        yield ChangeReadNotificationsSuccessState(
            message: response.message, model: event.model);
      } else {
        yield NotificationsErrorState(error: response.message);
        Fluttertoast.showToast(msg: response.message!);
      }
    } catch (error, stackTrace) {
      print("$tag  error $error ,  stackTrace $stackTrace");
    }
  }

  Stream<NotificationsState> _mapRemoveFromNotificationsToState(
      RemoveFromNotificationsButtonPressedEvent event) async* {
    yield NotificationsLoadingState();

    GeneralResponse response =
        await notificationsRepository.removeFromNotifiactions(event.model!);
    try {
      if (response.status!) {
        yield RemoveFromNotificationsSuccessState(
            message: response.message, model: event.model);
      } else {
        yield NotificationsErrorState(error: response.message);
        Fluttertoast.showToast(msg: response.message!);
      }
    } catch (error, stackTrace) {
      print("$tag  error $error ,  stackTrace $stackTrace");
    }
  }
}
