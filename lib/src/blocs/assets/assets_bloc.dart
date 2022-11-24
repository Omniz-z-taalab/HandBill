import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/repositories/assets_repository.dart';

import 'assets_event.dart';
import 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  String tag = "AssetBloc";

  AssetsRepository _auctionsRepository = AssetsRepository();
  int page = 1;
  bool isFetching = true;

  AssetsBloc({required BuildContext context})
      : super(AssetsInitialState()) ;

  @override
  Stream<AssetsState> mapEventToState(AssetsEvent event) async* {
    if (event is FetchAssetsEvent) {
      yield* _mapFetchAssets();
    }
  }

  Stream<AssetsState> _mapFetchAssets() async* {
    yield AssetsLoadingState();
    final response = await _auctionsRepository.getAssetsData();

    if (response.status!) {
      final items = response.data;
      yield AssetsSuccessState(items: items);
      page++;
      isFetching = false;
    } else {
      yield AssetsErrorState(error: response.message);
      isFetching = false;
    }
  }
}
