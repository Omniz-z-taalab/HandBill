import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/data/model/user.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsBySubCategoryEvent extends ProductsEvent {
  final String subcategoryId;
  final User? user;

  FetchProductsBySubCategoryEvent({required this.subcategoryId, this.user});

  @override
  List<Object?> get props => [subcategoryId];
}

class FetchSimilarProductsEvent extends ProductsEvent {
  final String subcategoryId;
  final User? user;

  FetchSimilarProductsEvent({required this.subcategoryId, this.user});

  @override
  List<Object?> get props => [subcategoryId];
}

// fetch details

class FetchProductDetails extends ProductsEvent {
  final int? id;

  FetchProductDetails({required this.id});
}
