import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/Services/Event.dart';
import 'package:hand_bill/src/blocs/Services/states.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';
import 'package:hand_bill/src/repositories/cubit.dart';
import 'package:hand_bill/src/repositories/search_repository.dart';

import '../../data/response/search/search_companies_response.dart';
import '../../ui/screens/services_package/shipping/ShippingBloc /ShippingState.dart';
import '../global_bloc/global_bloc.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/Services/Event.dart';
import 'package:hand_bill/src/blocs/Services/states.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';
import 'package:hand_bill/src/repositories/cubit.dart';
import 'package:hand_bill/src/repositories/search_repository.dart';

import '../../data/response/search/search_companies_response.dart';
import '../../ui/screens/services_package/shipping/ShippingBloc /ShippingState.dart';
import '../global_bloc/global_bloc.dart';

class ServiceBlocData extends Bloc<ServiceEvent, ServiceState> {
  String tag = "ServiceBloc";

  final ServiceRepository serviceRepository = ServiceRepository();
  final SearchRepository searchRepository = SearchRepository();
  late GlobalBloc globalBloc;
  int subCatPage = 1;

  // ServiceBloc() : super(ServiceInitialState());
  ServiceBlocData({required BuildContext context})
      : super(ServiceInitialState()) {
    globalBloc = BlocProvider.of<GlobalBloc>(context);

    on<FetchServiceEvent>(_mapFetchCategories);
    on<FetchData>(_mapFetchData);
    on<SearchMarketEvent>(_mapSearchCompanies);
  }

  void _mapSearchCompanies(
      SearchMarketEvent event, Emitter<ServiceState> emit) async {
    SearchCompaniesResponse? response;
    response = await searchRepository.getSearchCompanies(event.searchKey!);
    try {
      if (response == null) {
        emit(SearchCompaniesErrorState(errors: "error"));
      } else {
        emit(searchSuccess(company: response.data));
      }
    } catch (err) {
      emit(SearchCompaniesErrorState(errors: err.toString()));
    }
  }

  // void _mapBannerCompanies() async {
  //   emit(BannerCompanyLoadingState());
  //
  //   final response =
  //   await searchRepository.geySliderServiceData();
  //   try {
  //     if (response.data != null) {
  //       final banner = response.data;
  //       emit(BannerCompanySuccessState(banner));
  //     } else {
  //       // emit(SearchCompaniesErrorState(error: response.message.toString()));
  //     }
  //   } catch (err) {
  //     emit(BannerCompaniesErrorState(errors: err.toString()));
  //   }
  // }

  void _mapGetCompanies(ServiceCompanyEvent event) async {
    emit(SearchCompanyLoadingState());

    // final response =
    // await searchRepository.getServiceCompanies(event.searchKey);
    // try {
    //   if (response.data != null) {
    //     final companies = response.data;
    //     emit(getCompnySuccessState(company: companies));
    //   } else {
    //     // emit(SearchCompaniesErrorState(error: response.message.toString()));
    //   }
    // } catch (err) {
    //   emit(getCompnyErrorState(errors: err.toString()));
    // }
  }

  List<GetDataCategory>? categories;

  void _mapFetchCategories(
      FetchServiceEvent, Emitter<ServiceState> emit) async {
    emit(CategoriesAddLoadingState());
    final response = await serviceRepository.getServicesData();
    if (response.status!) {
      final items = response.data!;
      if (categories == null) {
        categories = items;
        // print(items!.first.name);
        print('omniaaaaaaaaaaaaaa');
      }
      emit(CategoriesAddSuccessState(items: items));
    } else {
      // emit(CategoryErrorState(errors: response.message.toString()));
    }
  }

  List<ServiceModel>? list;

  void _mapFetchData(FetchData, Emitter<ServiceState> emit) async {
    emit(categoryLoadState());
    final response = await serviceRepository.ServicesData();
    if (response.status!) {
      final items = response.data;
      if (list == null) {
        items!.first.selected = true;
        list = items;
        print(items.first.name);
        print('omniaaaaaaaaaaaaaa');
      }
      emit(categorySuccessState(items: items));
    } else {
      // emit(CategoryErrorState(errors: response.message.toString()));
    }
  }
}

// List<SubCategoryModel>? subCategories;
// // static List<SubCategoryModel>? _isolateSubCategories;
// bool isPaginationFinished = false;
// void _mapFetchSubCategories(
//     FetchSubCategoriesEvent event) async {
//   try {
//     if (isFetching == false && isPaginationFinished == true) return;
//     emit(CategoryLoadingState());
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
//       emit(SubCategoriesSuccessState(items: items));
//       // emit(SubCategoriesSuccessState(items: items));
//       subCatPage++;
//       isFetching = false;
//     } else {
//       emit(CategoryErrorState(errors: response.mess)a
