import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/repositories/assets_repository.dart';

import 'assets_event.dart';
import 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  String tag = "AssetBloc";

  AssetsRepository _auctionsRepository = AssetsRepository();
  int page = 1;
  bool isFetching = true;

  AssetsBloc({required BuildContext context}) : super(AssetsInitialState()) {
    on<FetchAssetsEvent>(_mapFetchAssets);
  }

  void _mapFetchAssets(
      FetchAssetsEvent event, Emitter<AssetsState> emit) async {
    emit(AssetsLoadingState());
    final response = await _auctionsRepository.getAssetsData();

    if (response.status!) {
      final items = response.data;
      emit(AssetsSuccessState(items: items));
      page++;
      isFetching = false;
    } else {
      emit(AssetsErrorState(error: response.message));
      isFetching = false;
    }
  }
}
