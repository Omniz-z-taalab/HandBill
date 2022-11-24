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

  HelpBloc({required BuildContext context})
      : super(HelpInitialState()) ;

  @override
  Stream<HelpState> mapEventToState(HelpEvent event) async* {
    if (event is FetchAgentEvent) {
      yield* _mapFetchAgent();
    }
    if(event is HelpCenterEvent){
      yield* _mapFetchHelpCenter();
    }
  }

  Stream<HelpState> _mapFetchAgent() async* {
    yield HelpLoadingState();
    final response = await _helpRepository.getAgentData();

    if (response.status!) {
      final items = response.data;
      yield AgentSuccessState(items: items);
      isFetching = false;
    } else {
      yield HelpErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<HelpState> _mapFetchHelpCenter() async* {
    yield HelpCenterLoading();
    final response = await _helpRepository.getHelpData();

    if (response.status!) {
      final items = response.data;
      print(items!.first.email!);
      yield HelpCenterSuccess(items: items);
    } else {
      yield HelpErrorState(error: response.message);
    }
  }
}
