import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/Services/Event.dart';
import 'package:hand_bill/src/blocs/Services/states.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';
import 'package:hand_bill/src/repositories/cubit.dart';
import 'package:hand_bill/src/repositories/search_repository.dart';

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
  }

  @override
  Stream<ServiceState> mapEventToState(ServiceEvent event) async* {
    if (event is FetchServiceEvent) {
      yield* _mapFetchCategories();
    }
    if (event is FetchData) {
      yield* _mapFetchData();
    }
    if (event is SearchMarketEvent) {
      yield* _mapSearchCompanies(event);
    }

    if (event is ServiceCompanyEvent) {
      yield* _mapGetCompanies(event);
    }
    // if (event is ServiceBannerCompanyEvent) {
      // yield* _mapBannerCompanies();
    // }
    // if (event is FetchSubCategoriesEvent) {
    //   yield* _mapFetchSubCategories(event);
    // }

  }

  Stream<ServiceState> _mapSearchCompanies(SearchMarketEvent event) async* {
    yield SearchCompanyLoadingState();

    final response =
    await searchRepository.getSearchCompanies(event.searchKey!);
    try {
      if (response.data != null) {
        final companies = response.data;
        yield searchSuccess(company: companies);
      } else {
        // yield SearchCompaniesErrorState(error: response.message.toString());
      }
    } catch (err) {
      yield SearchCompaniesErrorState(errors: err.toString());
    }
  }

  // Stream<ServiceState> _mapBannerCompanies() async* {
  //   yield BannerCompanyLoadingState();
  //
  //   final response =
  //   await searchRepository.geySliderServiceData();
  //   try {
  //     if (response.data != null) {
  //       final banner = response.data;
  //       yield BannerCompanySuccessState(banner);
  //     } else {
  //       // yield SearchCompaniesErrorState(error: response.message.toString());
  //     }
  //   } catch (err) {
  //     yield BannerCompaniesErrorState(errors: err.toString());
  //   }
  // }

  Stream<ServiceState> _mapGetCompanies(ServiceCompanyEvent event) async* {
    yield SearchCompanyLoadingState();

    final response =
    await searchRepository.getServiceCompanies(event.searchKey!);
    try {
      if (response.data != null) {
        final companies = response.data;
        yield getCompnySuccessState(company: companies);
      } else {
        // yield SearchCompaniesErrorState(error: response.message.toString());
      }
    } catch (err) {
      yield getCompnyErrorState(errors: err.toString());
    }
  }

  List<GetDataCategory>? categories;
  Stream<ServiceState> _mapFetchCategories() async* {
    yield CategoriesAddLoadingState();
    final response = await serviceRepository.getServicesData();
    if (response.status!) {
      final items = response.data!;
      if (categories == null) {
        categories = items;
        // print(items!.first.name);
        print('omniaaaaaaaaaaaaaa');
      }
      yield CategoriesAddSuccessState(items: items);
    } else {
      // yield CategoryErrorState(errors: response.message.toString());
    }
  }

  List<ServiceModel>? list;
  Stream<ServiceState> _mapFetchData() async* {
    yield categoryLoadState();
    final response = await serviceRepository.ServicesData();
    if (response.status!) {
      final items = response.data;
      if (list == null) {
        items!.first.selected = true;
        list = items;
        print(items!.first.name);
        print('omniaaaaaaaaaaaaaa');
      }
      yield categorySuccessState(items: items);
    } else {
      // yield CategoryErrorState(errors: response.message.toString());
    }
  }
}

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
  //       yield CategoryErrorState(errors: response.messa