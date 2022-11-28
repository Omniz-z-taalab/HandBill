import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/products/products_event.dart';
import 'package:hand_bill/src/blocs/products/products_state.dart';
import 'package:hand_bill/src/data/response/product/product_details_response.dart';
import 'package:hand_bill/src/repositories/products_repository.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  String tag = "ProductsBloc";
  ProductsRepository productsRepository = ProductsRepository();
  int page = 1;
  int similarPage = 1;
  bool isFetching = true;

  ProductsBloc({required BuildContext context})
      : super(ProductsInitialState()) {
    productsRepository.user = BlocProvider.of<GlobalBloc>(context).user;
  }

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is FetchProductsBySubCategoryEvent) {
      yield* _mapFetchProducts(event);
    }
    if (event is FetchSimilarProductsEvent) {
      yield* _mapFetchSimilarProducts(event);
    }

    if (event is FetchProductDetails) {
      yield* _mapFetchProductDetails(event);
    }
  }

  Stream<ProductsState> _mapFetchProducts(
      FetchProductsBySubCategoryEvent event) async* {
    yield ProductsLoadingState();
    final response = await productsRepository.getProductsBySubCategory(
        subcategoryId: event.subcategoryId);

    if (response.data!=null) {
      yield ProductsSuccessState(products: response.data);
      page++;
      isFetching = false;
    } else {
      // yield ProductsErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<ProductsState> _mapFetchSimilarProducts(
      FetchSimilarProductsEvent event) async* {
    yield ProductsLoadingState();
    final response = await productsRepository.getProductsBySubCategory(
        subcategoryId: event.subcategoryId,);

    if (response.data!=null) {
      yield SimilarProductsSuccessState(products: response.data);
      similarPage++;
      isFetching = false;
    } else {
      // yield ProductsErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<ProductsState> _mapFetchProductDetails(
      FetchProductDetails event) async* {
    yield ProductsLoadingState();

    ProductDetailsResponse response =
        await productsRepository.getProductDetail(id: event.id!);
    if (response.status!) {
      yield ProductDetailsSuccessState(model: response.data);
    } else {
      yield ProductsErrorState(error: response.message);
    }
  }
}
