import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/account_package/favorite_model.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteErrorState extends FavoriteState {
  final String? error;

  FavoriteErrorState({required this.error});
}
/////// fetch fav

class FavoriteSuccessState extends FavoriteState {
  final List<FavoriteModel>? items;

  FavoriteSuccessState({required this.items});
}
/////// is fav

class CheckIsFavoriteSuccessState extends FavoriteState {
  final String? message;
  final int? favoriteId;

  CheckIsFavoriteSuccessState(
      {required this.favoriteId, required this.message});
}

/////// add to fav

class AddToFavoriteSuccessState extends FavoriteState {
  final String? message;
  final int? favoriteId;

  AddToFavoriteSuccessState({required this.favoriteId, required this.message});
}

/////// remove to fav

class RemoveFromFavoriteSuccessState extends FavoriteState {
  final String? message;
  final int productId;

  RemoveFromFavoriteSuccessState(
      {required this.message, required this.productId});
}
