import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/repositories/offer_repository.dart';

import 'offers_event.dart';
import 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  String tag = "OfferBloc";

  OffersRepository _offersRepository = OffersRepository();
  int page = 1;
  bool isFetching = true;

  OffersBloc({required BuildContext context}) : super(OffersInitialState()) {
    on<FetchOffersEvent>(_mapFetchOffers);
  }

  void _mapFetchOffers(
      FetchOffersEvent event, Emitter<OffersState> emit) async {
    emit(OffersLoadingState());
    final response = await _offersRepository.getOffersData(page: page);

    if (response.status!) {
      final items = response.data;
      emit(OffersSuccessState(items: items));
      page++;
      isFetching = false;
    } else {
      emit(OffersErrorState(error: response.message));
      isFetching = false;
    }
  }
}
