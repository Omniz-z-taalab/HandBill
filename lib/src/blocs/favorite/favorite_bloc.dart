import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/data/response/account/favorite/add_to_favorite_response.dart';
import 'package:hand_bill/src/data/response/general_response.dart';
import 'package:hand_bill/src/repositories/favorite_repository.dart';

import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  String tag = "FavoriteBloc";

  late FavoriteRepository favoriteRepository;
  late BuildContext context;

  int page = 1;
  bool isFetching = false;

  FavoriteBloc({required this.context}) : super(FavoriteInitialState()) {
    favoriteRepository = FavoriteRepository(context: context);
    on<FetchFavoriteEvent>(_mapFetchFavorite);
    on<AddToFavoriteEvent>(_mapAddToFavoriteState);
    on<RemoveFromFavoriteEvent>(_mapRemoveFromFavoriteToState);
  }

  void _mapFetchFavorite(
      FetchFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());
    print(event.user);
    final response = await favoriteRepository.getFavoriteProducts(
        page: page, user: event.user);
    print('omniaaaaaaaaaaaaaaaa');
    if (response.status!) {
      final tours = response.data;
      print(tours);
      print('omniaaaaaaaaaaaaaaaa');
      emit(FavoriteSuccessState(items: tours));
      page++;
    } else {
      emit(FavoriteErrorState(error: response.message));
    }
  }

  void _mapAddToFavoriteState(
      AddToFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    AddToFavoriteResponse response = await favoriteRepository.addToFavorite(
        user: event.user, productId: event.productId!);

    if (response.status!) {
      emit(AddToFavoriteSuccessState(
          favoriteId: event.productId, message: response.message));
    } else {
      emit(FavoriteErrorState(error: response.message));
      Fluttertoast.showToast(msg: response.message!);
    }
  }

  void _mapRemoveFromFavoriteToState(
      RemoveFromFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    GeneralResponse response = await favoriteRepository.removeFromFavorite(
        favoriteId: event.favoriteId!, user: event.user);
    try {
      if (response.status!) {
        emit(RemoveFromFavoriteSuccessState(
            message: response.message, productId: event.favoriteId!));
      } else {
        emit(FavoriteErrorState(error: response.message));
        Fluttertoast.showToast(msg: response.message!);
      }
    } catch (error, stackTrace) {
      print("$tag  error $error ,  stackTrace $stackTrace");
    }
  }
}
