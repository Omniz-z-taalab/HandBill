import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/data/model/user.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchFavoriteEvent extends FavoriteEvent {
  final User user;

  FetchFavoriteEvent({required this.user}){
    print(user.name);
  }
}

class FetchIsFavorite extends FavoriteEvent {
  final int productId;

  FetchIsFavorite({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class AddToFavoriteEvent extends FavoriteEvent {
  final int? productId;
  final User user;

  AddToFavoriteEvent(
      {required this.user, required this.productId}){
    print(user.name);
    print('dddddddddddd');
    print(productId);
  }

  @override
  List<Object?> get props => [productId];
}

class RemoveFromFavoriteEvent extends FavoriteEvent {
  final int? favoriteId;
  final User user;
  RemoveFromFavoriteEvent({required this.user,required this.favoriteId});

  @override
  List<Object?> get props => [favoriteId];
}
