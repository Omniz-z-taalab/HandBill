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
    on<NotificationsFetchEvent>(_mapFetchNotifications);
    on<ChangeReadNotificationEvent>(_mapChangeReadNotificationsToState);
    on<RemoveFromNotificationsButtonPressedEvent>(
        _mapRemoveFromNotificationsToState);
  }

  void _mapFetchNotifications(
      NotificationsFetchEvent event, Emitter<NotificationsState> emit) async {
    emit(NotificationsLoadingState());

    final response =
        await notificationsRepository.getNotificationsData(page: page);

    if (response.status!) {
      final items = response.data;
      emit(NotificationsSuccessState(items: items));
      page++;
      isFetching = false;
    } else {
      emit(NotificationsErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapChangeReadNotificationsToState(ChangeReadNotificationEvent event,
      Emitter<NotificationsState> emit) async {
    emit(NotificationsLoadingState());

    GeneralResponse response =
        await notificationsRepository.markReadNotifiactions(event.model!);
    try {
      if (response.status!) {
        emit(ChangeReadNotificationsSuccessState(
            message: response.message, model: event.model));
      } else {
        emit(NotificationsErrorState(error: response.message));
        Fluttertoast.showToast(msg: response.message!);
      }
    } catch (error, stackTrace) {
      print("$tag  error $error ,  stackTrace $stackTrace");
    }
  }

  void _mapRemoveFromNotificationsToState(
      RemoveFromNotificationsButtonPressedEvent event,
      Emitter<NotificationsState> emit) async {
    emit(NotificationsLoadingState());

    GeneralResponse response =
        await notificationsRepository.removeFromNotifiactions(event.model!);
    try {
      if (response.status!) {
        emit(RemoveFromNotificationsSuccessState(
            message: response.message, model: event.model));
      } else {
        emit(NotificationsErrorState(error: response.message));
        Fluttertoast.showToast(msg: response.message!);
      }
    } catch (error, stackTrace) {
      print("$tag  error $error ,  stackTrace $stackTrace");
    }
  }
}
