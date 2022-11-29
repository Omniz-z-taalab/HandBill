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

  HandmadeBloc({required BuildContext context})
      : super(HandmadeInitialState()) {
    on<FetchHandmadeEvent>(_mapFetchAllHandmade);
    on<FetchMyHandmadeEvent>(_mapFetchMyHandmade);
    on<HandmadeAddEvent>(_mapAddHandmade);
    on<HandmadeRemoveEvent>(_mapRemoveHandmade);
  }

  //
  void _mapFetchAllHandmade(
      FetchHandmadeEvent event, Emitter<HandmadeState> emit) async {
    emit(HandmadeLoadingState());

    final response =
        await _handmadeRepository.getAllHandmadeData(page: allPage);

    if (response!.status!) {
      final items = response.data;
      emit(HandmadeSuccessState(items: items));
      allPage++;
      isFetching = false;
    } else {
      emit(HandmadeErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapFetchMyHandmade(
      FetchMyHandmadeEvent event, Emitter<HandmadeState> emit) async {
    emit(HandmadeLoadingState());
    final response =
        await _handmadeRepository.getMyHandmadeData(user: event.user);

    if (response!.status!) {
      final items = response.data;
      emit(MyHandmadeSuccessState(items: items));
      myPage++;
      isFetching = false;
    } else {
      emit(HandmadeErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapAddHandmade(
      HandmadeAddEvent event, Emitter<HandmadeState> emit) async {
    emit(HandmadeLoadingState());
    final response = await _handmadeRepository.addHandmade(
        model: event.model, user: event.user, images: event.images);

    if (response!.status!) {
      emit(HandmadeAddSuccessState(message: response.message!));
      isFetching = false;
    } else {
      emit(HandmadeErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapRemoveHandmade(
      HandmadeRemoveEvent event, Emitter<HandmadeState> emit) async {
    emit(HandmadeLoadingState());
    final response = await _handmadeRepository.removeHandmade(
        model: event.model, user: event.user);

    if (response!.status!) {
      emit(HandmadeRemoveSuccessState(
          message: response.message!, model: event.model));
      isFetching = false;
    } else {
      emit(HandmadeErrorState(error: response.message));
      isFetching = false;
    }
  }
}
