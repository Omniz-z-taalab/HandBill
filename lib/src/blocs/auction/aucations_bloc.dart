import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/repositories/auction_repository.dart';

import 'aucations_event.dart';
import 'aucations_state.dart';

class AuctionsBloc extends Bloc<AuctionsEvent, AuctionsState> {
  String tag = "AuctionBloc";

  AuctionsRepository _auctionsRepository = AuctionsRepository();
  int page = 1;
  bool isFetching = true;

  AuctionsBloc({required BuildContext context})
      : super(AuctionsInitialState()) ;

  @override
  Stream<AuctionsState> mapEventToState(AuctionsEvent event) async* {
    if (event is FetchAuctionsEvent) {
      yield* _mapFetchAuctions();
    }
  }

  Stream<AuctionsState> _mapFetchAuctions() async* {
    yield AuctionsLoadingState();
    final response = await _auctionsRepository.getAuctionsData(page: page);

    if (response.status!) {
      final items = response.data;
      yield AuctionsSuccessState(items: items);
      page++;
      isFetching = false;
    } else {
      yield AuctionsErrorState(error: response.message);
      isFetching = false;
    }
  }
}
