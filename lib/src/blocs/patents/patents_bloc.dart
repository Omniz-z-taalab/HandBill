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

  PatentsBloc({required BuildContext context}) : super(PatentsInitialState()) {}

  @override
  Stream<PatentsState> mapEventToState(PatentsEvent event) async* {
    // if (event is FetchPatentsEvent) {
    //   yield* _mapFetchAllPatents();
    // }
    if (event is FetchMyPatentsEvent) {
      yield* _mapFetchMyPatents(event);
    }
    if (event is PatentedAddEvent) {
      yield* _mapAddPatented(event);
    }
    if (event is PatentedRemoveEvent) {
      yield* _mapRemovePatented(event);
    }
  }

  // Stream<PatentsState> _mapFetchAllPatents() async* {
  //   yield PatentsLoadingState();
  //   final response = await _patentsRepository.getAllPatentsData(page: allPage);
  //
  //   if (response!.status!) {
  //     final items = response.data;
  //     yield PatentsSuccessState(items: items);
  //     allPage++;
  //     isFetching = false;
  //   } else {
  //     yield PatentsErrorState(error: response.message);
  //     isFetching = false;
  //   }
  // }

  Stream<PatentsState> _mapFetchMyPatents(FetchMyPatentsEvent event) async* {
    yield PatentsLoadingState();
    final response = await _patentsRepository.getMyPatentsData(user: event.user);

    if (response!.status!) {
      final items = response.data;
      print(items!.first.title);
      yield MyPatentsSuccessState(items: items);
      myPage++;
      isFetching = false;
    } else {
      yield PatentsErrorState(error: response.message);
      isFetching = false;
    }
  }

  // add
  Stream<PatentsState> _mapAddPatented(PatentedAddEvent event) async* {
    yield PatentsLoadingState();
    final response = await _patentsRepository.addPatented(
        model: event.model, user: event.user, images: event.images);

    if (response!.status!) {
      yield PatentedAddSuccessState(message: response.message!);
      isFetching = false;
    } else {
      yield PatentsErrorState(error: response.message);
      isFetching = false;
    }
  }

  // remove
  Stream<PatentsState> _mapRemovePatented(PatentedRemoveEvent event) async* {
    yield PatentsLoadingState();
    final response = await _patentsRepository.removePatented(
        model: event.model, user: event.user);

    if (response!.status!) {
      yield PatentedRemoveSuccessState(
          message: response.message!, model: event.model);
      isFetching = false;
    } else {
      yield PatentsErrorState(error: response.message);
      isFetching = false;
    }
  }
}
