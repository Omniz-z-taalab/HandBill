import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/model/Search_data.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchProductEvent extends SearchEvent {
  final String? searchKey;

  SearchProductEvent({required this.searchKey}){
    print(searchKey);
  }
}
class SearchComEvent extends SearchEvent {
  final String? searchKey;

  SearchComEvent({required this.searchKey}){
    print(searchKey);
  }
}

// class SearchMarketEvent extends SearchEvent {
//  class SearchMarketEvent extends SearchEvent {
// //   final String? searchKey;
// //
// //   SearchMarketEvent({required this.searchKey}){
// //   } final String? searchKey;
//
//   SearchMarketEvent({required this.searchKey}){
//   }
// }
class CategoryCompanyEvent extends SearchEvent {
}

class SearchAllCategoriesEvent extends SearchEvent{}

class SearchAllSubCategoriesEvent extends SearchEvent{
  final int id;
  SearchAllSubCategoriesEvent({required this.id});}

class SearchSubSubCategoriesEvent extends SearchEvent{
  final int id;
  SearchSubSubCategoriesEvent({required this.id});

}
class ProductEvent extends SearchEvent{
  final int id;
  ProductEvent({required this.id}){
    print(id.toString());
  }

}
class ProducttEvent extends SearchEvent{
  final int id;
  ProducttEvent({required this.id}){
    print(id.toString());
  }

}
class  isFavourite extends SearchEvent{final String? num;
  isFavourite({required this.num}){
    print('ddsdsdsdd');
    print(num);
  }
}