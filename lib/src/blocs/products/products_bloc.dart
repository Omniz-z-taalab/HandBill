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
    on<FetchProductsBySubCategoryEvent>(_mapFetchProducts);
    on<FetchSimilarProductsEvent>(_mapFetchSimilarProducts);
    on<FetchProductDetails>(_mapFetchProductDetails);
  }

  void _mapFetchProducts(FetchProductsBySubCategoryEvent event,
      Emitter<ProductsState> emit) async {
    emit(ProductsLoadingState());
    final response = await productsRepository.getProductsBySubCategory(
        subcategoryId: event.subcategoryId);

    if (response.status!) {
      emit(ProductsSuccessState(products: response.data));
      page++;
      isFetching = false;
    } else {
      emit(ProductsErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapFetchSimilarProducts(
      FetchSimilarProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoadingState());
    final response = await productsRepository.getProductsBySubCategory(
      subcategoryId: event.subcategoryId,
    );

    if (response.status!) {
      emit(SimilarProductsSuccessState(products: response.data));
      similarPage++;
      isFetching = false;
    } else {
      emit(ProductsErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapFetchProductDetails(
      FetchProductDetails event, Emitter<ProductsState> emit) async {
    emit(ProductsLoadingState());

    ProductDetailsResponse response =
        await productsRepository.getProductDetail(id: event.id!);
    if (response.status!) {
      emit(ProductDetailsSuccessState(model: response.data));
    } else {
      emit(ProductsErrorState(error: response.message));
    }
  }
}
