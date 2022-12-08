import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/category/category_state.dart';
import 'package:hand_bill/src/blocs/search/search_event.dart';
import 'package:hand_bill/src/blocs/search/search_state.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/repositories/search_repository.dart';

import '../../data/model/ServiceCategory/serviceCategory.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  String tag = "SearchBloc";

  final SearchRepository searchRepository = SearchRepository();
  int page = 1;
  bool isFetching = false;
  String num = "0";

  SearchBloc({required BuildContext context}) : super(SearchInitialState()) {
    on<SearchProductEvent>(_mapSearchProduct);
    on<SearchComEvent>(_mapSearchcompany);
    on<SearchAllCategoriesEvent>(_mapSearchCategories);
    on<SearchAllSubCategoriesEvent>(_mapSearchSubCategories);
    on<SearchSubSubCategoriesEvent>(_mapSearchSubSubCategories);
    on<ProductEvent>(SearchProduct);
    on<ProducttEvent>(SearchProduuct);
    // on<isFavourite>(isFavouriteSuccessState);
  }

  void _mapSearchProduct(
      SearchProductEvent event, Emitter<SearchState> emit) async {

    emit(SearchProductsLoadingState());
    var response = await searchRepository.getSearchProducts(event.searchKey!);
    try {
      print(response.data);
      if (response.status!) {
        final products = response.data!;
        print('omniaaa');
        print(products);
        // print(products!.data!.first.name);
        emit(SearchProductsSuccessState(products: products));
      } else {
        emit(SearchProductsErrorState(error: response.message.toString()));
      }
    } catch (err) {
      emit(SearchProductsErrorState(error: err.toString()));
    }
  }

  void _mapSearchcompany(
      SearchComEvent event, Emitter<SearchState> emit) async {
    emit(SearchProductsLoadingState());
    var response = await searchRepository.getSearchProducts(event.searchKey!);
    try {
      print(response.data);
      if (response.status!) {
        final products = response.data!;
        emit(SearchcompanySuccessState(products: products));
      } else {
        emit(SearchProductsErrorState(error: response.message.toString()));
      }
    } catch (err) {
      emit(SearchProductsErrorState(error: err.toString()));
    }
  }

  // Stream<SearchState> _mapSearchCompanies(SearchMarketEvent event, Emitter<SearchState> emit) async {
  //   emit(earchCompaniesLoadingState());
  //
  //   final response =
  //       await searchRepository.getSearchCompanies(event.searchKey!);
  //   try {
  //     if (response.data != null) {
  //       final companies = response.data;
  //       emit(earchCompaniesSuccessState(companies: companies));
  //     } else {
  //       // emit(earchCompaniesErrorState(error: response.message.toString()));
  //     }
  //   } catch (err) {
  //     emit(earchCompaniesErrorState(error: err.toString()));
  //   }
  // }

  void _mapSearchCategories(
      SearchAllCategoriesEvent event, Emitter<SearchState> emit) async {
    emit(SearchCategoriesLoadingState());
    final response = await searchRepository.getAllCategories();
    try {
      if (response.data != null) {
        print(response.data);
        print('ssasaas');
        final products = response.data;
        emit(SearchCategoriesSuccessState(products: products));
      } else {
        emit(SearchCategoriesErrorState(error: response.message.toString()));
      }
    } catch (err) {
      emit(SearchCategoriesErrorState(error: err.toString()));
    }
  }

  void _mapSearchSubCategories(
      SearchAllSubCategoriesEvent event, Emitter<SearchState> emit) async {
    emit(SearchSubCategoriesLoadingState());
    final response = await searchRepository.getAllSubCategories(event.id);

    try {
      if (response.data != null) {
        final subCategories = response.data;
        emit(SearchSubCategoriesSuccessState(subCategories: subCategories));
      } else {
        print(response.message);
        emit(SearchSubCategoriesErrorState(error: response.message.toString()));
      }
    } catch (err) {
      emit(SearchSubCategoriesErrorState(error: err.toString()));
    }
  }

  void _mapSearchSubSubCategories(
      SearchSubSubCategoriesEvent event, Emitter<SearchState> emit) async {
    emit(SearchSubSubCategoriesLoadingState());
    final response = await searchRepository.getSubSubCategories(event.id);

    try {
      if (response.data != null) {
        final subSubCategories = response.data;
        emit(SearchSubSubCategoriesSuccessState(
            subSubCategories: subSubCategories));
      } else {
        print(response.message);
        emit(SearchSubCategoriesErrorState(error: response.message.toString()));
      }
    } catch (err) {
      emit(SearchSubSubCategoriesErrorState(error: err.toString()));
    }
  }

// final List<Product products;
  void SearchProduct(ProductEvent event, Emitter<SearchState> emit) async {
    emit(ProductLoadingState());
    final response = await searchRepository.getSearchProduct(event.id);
    try {
      if (response.status!) {
        print('wwwweeeeee');
        // final products = response.data!.products!.data;
        emit(ProductSuccesssState(products: response.data));
      } else {
        emit(ProductErrorState(error: response.message.toString()));
      }
    } catch (err) {
      emit(SearchProductsErrorState(error: err.toString()));
    }
  }
  void SearchProduuct(ProducttEvent event, Emitter<SearchState> emit) async {
    emit(ProductLoadingState());
    final response = await searchRepository.getSearchProduct(event.id);
    try {
      if (response.status!) {
        print('wwwweeeeee');
        // final products = response.data!.products!.data;
        emit(ProductSuccesssState(products: response.data));
      } else {
        emit(ProductErrorState(error: response.message.toString()));
      }
    } catch (err) {
      emit(SearchProductsErrorState(error: err.toString()));
    }
  }
}
