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
  SearchBloc({required BuildContext context}) : super(SearchInitialState());
  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchProductEvent) {
      yield* _mapSearchProduct(event);}
    if(event is SearchComEvent){
      yield* _mapSearchcompany(event);
    }

    // if (event is SearchMarketEvent) {
    //   yield* _mapSearchCompanies(event);
    // }
    if (event is SearchAllCategoriesEvent) {
      yield* _mapSearchCategories();
    }
    if (event is SearchAllSubCategoriesEvent) {
      yield* _mapSearchSubCategories(event);
    }
    if (event is SearchSubSubCategoriesEvent) {
      yield* _mapSearchSubSubCategories(event);
    }

    if (event is ProductEvent) {
       yield* SearchProduct(event);
    }
    if (event is isFavourite) {
      if (event.num == "1") {
        num = event.num! ;}
        emit( isFavouriteSuccessState(num: event.num));
    }
  }

  Stream<SearchState> _mapSearchProduct(SearchProductEvent event) async* {
    yield SearchProductsLoadingState();
    var response = await searchRepository.getSearchProducts(event.searchKey!);
    try {
      print(response.data);
      if (response.status!) {
        final products = response.data!;
        print('omniaaa');
        print(products);
        // print(products!.data!.first.name);
        yield SearchProductsSuccessState(products: products);
      } else {
        yield SearchProductsErrorState(error: response.message.toString());
      }
    } catch (err) {
      yield SearchProductsErrorState(error: err.toString());
    }
  }
  Stream<SearchState> _mapSearchcompany(SearchComEvent event) async* {
    yield SearchProductsLoadingState();
    var response = await searchRepository.getSearchProducts(event.searchKey!);
    try {
      print(response.data);
      if (response.status!) {
        final products = response.data!;
        print('omniaaa');
        print(products);
        yield SearchcompanySuccessState(products: products);
      } else {
        yield SearchProductsErrorState(error: response.message.toString());
      }
    } catch (err) {
      yield SearchProductsErrorState(error: err.toString());
    }
  }

  // Stream<SearchState> _mapSearchCompanies(SearchMarketEvent event) async* {
  //   yield SearchCompaniesLoadingState();
  //
  //   final response =
  //       await searchRepository.getSearchCompanies(event.searchKey!);
  //   try {
  //     if (response.data != null) {
  //       final companies = response.data;
  //       yield SearchCompaniesSuccessState(companies: companies);
  //     } else {
  //       // yield SearchCompaniesErrorState(error: response.message.toString());
  //     }
  //   } catch (err) {
  //     yield SearchCompaniesErrorState(error: err.toString());
  //   }
  // }


  Stream<SearchState> _mapSearchCategories() async* {
    yield SearchCategoriesLoadingState();
    final response = await searchRepository.getAllCategories();
    try {
      if (response?.data != null) {
        print(response!.data);
        print('ssasaas');
        final products = response?.data;
        yield SearchCategoriesSuccessState(products: products);
      } else {
        yield SearchCategoriesErrorState(error: response!.message.toString());
      }
    } catch (err) {
      yield SearchCategoriesErrorState(error: err.toString());
    }
  }

  Stream<SearchState> _mapSearchSubCategories(SearchAllSubCategoriesEvent event) async* {
    yield SearchSubCategoriesLoadingState();
    final response = await searchRepository.getAllSubCategories(event.id);
    print(event.id);
    print(response.data);
    print('lalalaalalalalaalalalalal');
    try {
      if (response?.data != null) {
        final subCategories = response.data;
        yield SearchSubCategoriesSuccessState(subCategories: subCategories);
      } else {
        print(response.message);
        yield SearchSubCategoriesErrorState(error: response.message.toString());
      }
    } catch (err) {
      yield SearchSubCategoriesErrorState(error: err.toString());
    }
  }

  Stream<SearchState> _mapSearchSubSubCategories(
      SearchSubSubCategoriesEvent event) async* {
    yield SearchSubSubCategoriesLoadingState();
    final response = await searchRepository.getSubSubCategories(event.id);
    print(event.id);
    print(response.data);
    print('lalalaalalalalaalalalalal');
    try {
      if (response?.data != null) {
        final subSubCategories = response.data;
        yield SearchSubSubCategoriesSuccessState(
            subSubCategories: subSubCategories);
      } else {
        print(response.message);
        yield SearchSubCategoriesErrorState(error: response.message.toString());
      }
    } catch (err) {
      yield SearchSubSubCategoriesErrorState(error: err.toString());
    }
  }
// final List<Product products;
  Stream<SearchState> SearchProduct(ProductEvent event) async* {
    yield ProductLoadingState();
    final response = await searchRepository.getSearchProduct(event.id);
    try {
      if (response.status!) {
        final products = response.data!.products!.data;
        yield ProductSuccessState(products: products);
      } else {
        yield ProductErrorState(error: response.message.toString());
      }
    } catch (err) {
      yield SearchProductsErrorState(error: err.toString());
    }
  }


}
