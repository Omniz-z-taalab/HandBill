import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/repositories/hand_made_repository.dart';

import 'hand_made_event.dart';
import 'hand_made_state.dart';

class HandmadeBloc extends Bloc<HandmadeEvent, HandmadeState> {
  String tag = "Handmade Bloc";

  HandmadeRepository _handmadeRepository = HandmadeRepository();
  int allPage = 1;
  int myPage = 1;
  bool isFetching = true;

  HandmadeBloc({required BuildContext context}) : super(HandmadeInitialState());

  @override
  Stream<HandmadeState> mapEventToState(HandmadeEvent event) async* {
    if (event is FetchHandmadeEvent) {
      yield* _mapFetchAllHandmade();
    }
    if (event is FetchMyHandmadeEvent) {
      yield* _mapFetchMyHandmade(event);
    }
    if (event is HandmadeAddEvent) {
      yield* _mapAddHandmade(event);
    }
    if (event is HandmadeRemoveEvent) {
      yield* _mapRemoveHandmade(event);
    }
  }
  //
  Stream<HandmadeState> _mapFetchAllHandmade() async* {
    yield HandmadeLoadingState();
    final response =
        await _handmadeRepository.getAllHandmadeData(page: allPage);

    if (response!.status!) {
      final items = response.data;
      yield HandmadeSuccessState(items: items);
      allPage++;
      isFetching = false;
    } else {
      yield HandmadeErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<HandmadeState> _mapFetchMyHandmade(FetchMyHandmadeEvent event) async* {
    yield HandmadeLoadingState();
    final response = await _handmadeRepository.getMyHandmadeData(user: event.user);

    if (response!.status!) {
      final items = response.data;
      yield MyHandmadeSuccessState(items: items);
      myPage++;
      isFetching = false;
    } else {
      yield HandmadeErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<HandmadeState> _mapAddHandmade(HandmadeAddEvent event) async* {
    yield HandmadeLoadingState();
    final response = await _handmadeRepository.addHandmade(
        model: event.model, user: event.user, images: event.images);

    if (response!.status!) {
      yield HandmadeAddSuccessState(message: response.message!);
      isFetching = false;
    } else {
      yield HandmadeErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<HandmadeState> _mapRemoveHandmade(HandmadeRemoveEvent event) async* {
    yield HandmadeLoadingState();
    final response = await _handmadeRepository.removeHandmade(
        model: event.model, user: event.user);

    if (response!.status!) {
      yield HandmadeRemoveSuccessState(
          message: response.message!, model: event.model);
      isFetching = false;
    } else {
      yield HandmadeErrorState(error: response.message);
      isFetching = false;
    }
  }
}
