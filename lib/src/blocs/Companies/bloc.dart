import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/Services/Event.dart';
import 'package:hand_bill/src/blocs/Services/states.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';
import 'package:hand_bill/src/repositories/cubit.dart';
import 'package:hand_bill/src/repositories/search_repository.dart';

import '../global_bloc/global_bloc.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  String tag = "ServiceBloc";

  final ServiceRepository serviceRepository = ServiceRepository();
  final SearchRepository searchRepository = SearchRepository();
  late GlobalBloc globalBloc;

  ServiceBloc({required BuildContext context}) : super(ServiceInitialState());
  @override
  Stream<ServiceState> mapEventToState(ServiceEvent event) async* {
    if (event is FetchServiceEvent) {
      yield* mapFetchCategories();
    }
    // if(event is SearchMarketEvent){
      // yield* _mapSearchCompanies(event);
    // }
    // if (event is FetchSubCategoriesEvent) {
    //   yield* _mapFetchSubCategories(event);
    // }
  }

  List<GetDataCategory>? categories;
  Stream<ServiceState> mapFetchCategories() async* {
    yield CategoryLoadingState();
    final response = await serviceRepository.getServicesData();
    if (response.status!) {
      final items = response.data;
      if (categories == null) {
        // items!.first.selected = true;
        categories = items;
      }
      yield CategoriesSuccessState( categories);
    } else {
      yield CategoryErrorState(errors: response.message.toString());
    }
  }
  // Stream<ServiceState> _mapSearchCompanies(SearchMarketEvent event) async* {
  //   yield SearchCompaniesLoadingState();
  //
  //   final response =
  //   await searchRepository.getSearchCompanies(event.searchKey!);
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

  // List<SubCategoryModel>? subCategories;
  // // static List<SubCategoryModel>? _isolateSubCategories;
  // bool isPaginationFinished = false;
  // Stream<ServiceState> _mapFetchSubCategories(
  //     FetchSubCategoriesEvent event) async* {
  //   try {
  //     if (isFetching == false && isPaginationFinished == true) return;
  //     yield CategoryLoadingState();
  //     print("get more data ");
  //     final response = await categoryRepository.getSubCategoriesData(
  //         categoryId: event.categoryId, page: subCatPage);
  //     if (response.status!) {
  //       final items = response.data;
  //       if (items!.length == 0) {
  //         isPaginationFinished = true;
  //         isFetching = false;
  //       }
  //       if (subCategories == null) subCategories = items;
  //       yield SubCategoriesSuccessState(items: items);
  //       // emit(SubCategoriesSuccessState(items: items));
  //       subCatPage++;
  //       isFetching = false;
  //     } else {
  //       yield CategoryErrorState(errors: response.message.toString());
  //       isFetching = false;
  //     }
  //   } catch (e) {
  //     yield CategoryErrorState(errors: "error can not get data now ");
  //     isFetching = false;
  //     // log(">>>>>>>>>>>>>${e.toString()} ");
  //   }
  // }

  // compute(parseSubCategories,items);
  // static parseSubCategories(final responseBody) {
  //   _isolateSubCategories = responseBody;
  //   print("compute isolate parser sub categories list");
  //   print("${ServiceBloc.subCategories!.first.name}");
  // }

}
