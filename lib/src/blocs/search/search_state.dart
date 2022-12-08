import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hand_bill/src/data/model/Search_data.dart';
import 'package:hand_bill/src/data/model/ServiceCategory/serviceCategory.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/market.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/model/search_Subcategoreis_model.dart';
import 'package:hand_bill/src/data/response/search/search_companies_response.dart';
import 'package:hand_bill/src/data/response/search/search_product_response.dart';

import '../../data/response/search/search_categories_response.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {
  const SearchInitialState();
}

//// products

class SearchProductsLoadingState extends SearchState {}

class SearchProductsSuccessState extends SearchState {
  final AllDataSearch? products;

   SearchProductsSuccessState({required this.products}){
     print('ssssssss');
    // print(products!.first.name);
  }
}


class SearchcompanySuccessState extends SearchState {
   final AllDataSearch? products;

   SearchcompanySuccessState({required this.products}){
    print('fggfgfgfg');
     // print(products!.name!);
  }
}

class SearchProductsErrorState extends SearchState {
  final String error;

  const SearchProductsErrorState({required this.error});
}

//// companies

class SearchCompaniesLoadingState extends SearchState {}

class SearchCompaniesSuccessState extends SearchState {
  final List<DataCompanySearch>? companies;

   SearchCompaniesSuccessState({required this.companies})
  {
    print(companies!.first.name);
    print('ddddddddddddd');
  }
}
class SearchCompaniesErrorState extends SearchState{
  final String error;

  const SearchCompaniesErrorState({required this.error});
}
//categories company
class CategoryCompaniesLoadingState extends SearchState {}

// class CategoryCompanyState extends SearchState{
//   final List<ServiceCategoryModel>? company;
//   CategoryCompanyState({required this.company});
//
// }

class CategoryCompaniesErrorState extends SearchState {
  final String error;

  const CategoryCompaniesErrorState({required this.error});
}
//categories Product
class SearchCategoriesLoadingState extends SearchState {}

class SearchCategoriesSuccessState extends SearchState {
List<SubCategorySearch>? products;
SearchCategoriesSuccessState({this.products});
}

class SearchCategoriesErrorState extends SearchState {
  final String error;

  const SearchCategoriesErrorState({required this.error});
}

class SearchSubCategoriesLoadingState extends SearchState {}

class SearchSubCategoriesSuccessState extends SearchState {
  List<SearchData>? subCategories;
  SearchSubCategoriesSuccessState({this.subCategories}){
    print('omniaaaaaaaaaa');
    print(subCategories);
  }
}

class SearchSubCategoriesErrorState extends SearchState {
  final String error;

  const SearchSubCategoriesErrorState({required this.error});
}

class SearchSubSubCategoriesLoadingState extends SearchState {}

class SearchSubSubCategoriesSuccessState extends SearchState {
  List<Categories>? subSubCategories;
  SearchSubSubCategoriesSuccessState({this.subSubCategories}){
    print('omniaaaaaaaaaa');

    print(subSubCategories);
  }
}

class SearchSubSubCategoriesErrorState extends SearchState {
  final String error;

  const SearchSubSubCategoriesErrorState({required this.error});
}


class ProductLoadingState extends SearchState {}

class ProductSuccessState extends SearchState {
  final List<DataProductSearch>? products;

   ProductSuccessState({required this.products}){
  }
}
class ProductSuccesssState extends SearchState {
  final List<Product>? products;
   ProductSuccesssState({required this.products}){
    print('ddddfffffgggggg');

  }
}

class ProductErrorState extends SearchState {
  final String error;

  const ProductErrorState({required this.error});
}

class isFavouriteSuccessState extends SearchState{
  final String? num;
  isFavouriteSuccessState({required this.num}){
    print(num);
    print('object');
  }

}