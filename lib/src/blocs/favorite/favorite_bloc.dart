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
  }

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is FetchFavoriteEvent) {
      yield* _mapFetchFavorite(event);
    }

    if (event is AddToFavoriteEvent) {
      yield* _mapAddToFavoriteState(event);
    }
    if (event is RemoveFromFavoriteEvent) {
      yield* _mapRemoveFromFavoriteToState(event);
    }
  }

  Stream<FavoriteState> _mapFetchFavorite(FetchFavoriteEvent event) async* {
    yield FavoriteLoadingState();
    print(event.user);
    final response = await favoriteRepository.getFavoriteProducts(
        page: page, user: event.user);
    print('omniaaaaaaaaaaaaaaaa');
    if (response.status!) {
      final tours = response.data;
      print(tours);
      print('omniaaaaaaaaaaaaaaaa');
      yield FavoriteSuccessState(items: tours);
      page++;
    } else {
      yield FavoriteErrorState(error: response.message);
    }
  }

  Stream<FavoriteState> _mapAddToFavoriteState(
      AddToFavoriteEvent event) async* {
    yield FavoriteLoadingState();

    AddToFavoriteResponse response = await favoriteRepository.addToFavorite(
        user: event.user, productId: event.productId!);

    if (response.status!) {
      yield AddToFavoriteSuccessState(
          favoriteId: event.productId, message: response.message);
    } else {
      yield FavoriteErrorState(error: response.message);
      Fluttertoast.showToast(msg: response.message!);
    }
  }

  Stream<FavoriteState> _mapRemoveFromFavoriteToState(
      RemoveFromFavoriteEvent event) async* {
    yield FavoriteLoadingState();

    GeneralResponse response = await favoriteRepository.removeFromFavorite(
        favoriteId: event!.favoriteId!, user: event.user);
    try {
      if (response.status!) {
        yield RemoveFromFavoriteSuccessState(
            message: response.message, productId: event!.favoriteId!);
      } else {
        yield FavoriteErrorState(error: response.message);
        Fluttertoast.showToast(msg: response.message!);
      }
    } catch (error, stackTrace) {
      print("$tag  error $error ,  stackTrace $stackTrace");
    }
  }
}
