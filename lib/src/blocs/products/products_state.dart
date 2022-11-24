import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/response/product/product_details_response.dart';

import '../../data/response/search/search_product_response.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsErrorState extends ProductsState {
  final String? error;

  ProductsErrorState({required this.error});
}

// fetch product
class ProductsSuccessState extends ProductsState {
  final List<Product>? products;

  ProductsSuccessState({required this.products});
}

// fetch product
class SimilarProductsSuccessState extends ProductsState {
  final List<Product>? products;

  SimilarProductsSuccessState({required this.products});
}

// fetch details

class ProductDetailsSuccessState extends ProductsState {
  final DataProductSearch? model;

  ProductDetailsSuccessState({this.model});
}
