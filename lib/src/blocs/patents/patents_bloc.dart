import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/patents/patents_event.dart';
import 'package:hand_bill/src/repositories/patents_repository.dart';

import 'patents_state.dart';

class PatentsBloc extends Bloc<PatentsEvent, PatentsState> {
  String tag = "PatentsBloc";

  PatentsRepository _patentsRepository = PatentsRepository();
  int allPage = 1;
  int myPage = 1;
  bool isFetching = true;

  PatentsBloc({required BuildContext context}) : super(PatentsInitialState()) {
    on<FetchMyPatentsEvent>(_mapFetchMyPatents);
    on<PatentedAddEvent>(_mapAddPatented);
    on<PatentedRemoveEvent>(_mapRemovePatented);
  }

  void _mapFetchMyPatents(
      FetchMyPatentsEvent event, Emitter<PatentsState> emit) async {
    emit(PatentsLoadingState());
    final response =
        await _patentsRepository.getMyPatentsData(user: event.user);

    if (response!.status!) {
      final items = response.data;
      print(items!.first.title);
      emit(MyPatentsSuccessState(items: items));
      myPage++;
      isFetching = false;
    } else {
      emit(PatentsErrorState(error: response.message));
      isFetching = false;
    }
  }

  // add
  void _mapAddPatented(
      PatentedAddEvent event, Emitter<PatentsState> emit) async {
    emit(PatentsLoadingState());
    final response = await _patentsRepository.addPatented(
        model: event.model, user: event.user, images: event.images);

    if (response!.status!) {
      emit(PatentedAddSuccessState(message: response.message!));
      isFetching = false;
    } else {
      emit(PatentsErrorState(error: response.message));
      isFetching = false;
    }
  }

  // remove
  void _mapRemovePatented(
      PatentedRemoveEvent event, Emitter<PatentsState> emit) async {
    emit(PatentsLoadingState());
    final response = await _patentsRepository.removePatented(
        model: event.model, user: event.user);

    if (response!.status!) {
      emit(PatentedRemoveSuccessState(
          message: response.message!, model: event.model));
      isFetching = false;
    } else {
      emit(PatentsErrorState(error: response.message));
      isFetching = false;
    }
  }
}
