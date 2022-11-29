import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/repositories/auction_repository.dart';
import 'package:hand_bill/src/repositories/help_repository.dart';

import 'help_event.dart';
import 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  String tag = "HelpBloc";

  HelpRepository _helpRepository = HelpRepository();
  bool isFetching = true;

  HelpBloc({required BuildContext context}) : super(HelpInitialState()) {
    on<FetchAgentEvent>(_mapFetchAgent);
    on<HelpCenterEvent>(_mapFetchHelpCenter);
  }

  void _mapFetchAgent(FetchAgentEvent event, Emitter<HelpState> emit) async {
    emit(HelpLoadingState());
    final response = await _helpRepository.getAgentData();

    if (response.status!) {
      final items = response.data;
      emit(AgentSuccessState(items: items));
      isFetching = false;
    } else {
      emit(HelpErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapFetchHelpCenter(
      HelpCenterEvent event, Emitter<HelpState> emit) async {
    emit(HelpCenterLoading());
    final response = await _helpRepository.getHelpData();

    if (response.status!) {
      final items = response.data;
      print(items!.first.email!);
      emit(HelpCenterSuccess(items: items));
    } else {
      emit(HelpErrorState(error: response.message));
    }
  }
}
