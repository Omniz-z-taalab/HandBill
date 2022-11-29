import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/data/model/category/sub.dart';
import 'package:hand_bill/src/data/model/category/sub_sub.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/ShippingBloc%20/ShippingEvent.dart';

import 'package:hand_bill/src/ui/screens/services_package/shipping/states.dart';

import '../../../../../common/api_data.dart';
import '../../../../../common/global.dart';
import '../../../../../data/model/services/companies.dart';
import '../../../../../data/response/banner/sub_product.dart';
import '../../../../../repositories/home_repository.dart';
import 'ShippingState.dart';

class ShippingBloc extends Bloc<ShippingInitEvent, ShippingState> {
  String tag = "ShippingBloc";

  final HomeRepository homeRepository = HomeRepository();
  List<DataPro> sliders = [];

  Dio _dio = Dio();

  Future<void> getdata() async {}

  ShippingBloc() : super(ShippingInitState()) {
    on<ShippingSliderEvent>(_mapFetchSlider);
    on<ShippingSubCategoryEvent>(_mapCategory);
    on<ShippingSubSubCategoryEvent>(_mapSubCategory);
    on<ShippingSliderServiceEvent>(_mapBannerCompanies);
    on<ShippingCategoryServiceEvent>(_mapCategoryService);
  }

  // CompanyModel? companyModel;

  CompanyModel? companyModel;

  void _mapBannerCompanies(
      ShippingSliderServiceEvent event, Emitter<ShippingState> emit) async {
    emit(BannerCompanyLoadingState());

    final response = await homeRepository.geySliderServiceData();
    try {
      if (response.data != null) {
        final banner = response.data;
        emit(BannerCompanySuccessState(banner));
      } else {
        // emit(SearchCompaniesErrorState(error: response.message.toString()));
      }
    } catch (err) {
      emit(BannerCompaniesErrorState(err.toString()));
    }
  }

  Future<void> getCategory({required subNature}) async {
    String? value = await storage.read(key: "lang");

    Map<String, String> queryParams =
        ({"secret": APIData.secretKey, "language": value!});
    _dio
        .get(APIData.getShippingCompanies + subNature,
            queryParameters: queryParams)
        .then((value) {
      companyModel = CompanyModel.fromJson(value.data);
      emit(ShippingSuccessCategoryState());
    }).catchError((error) {
      emit(ShippingErrorCategoryState(error.toString()));
    });
  }

  SubCategoryModel? subCategoryModel;

  void _mapFetchSlider(
      ShippingSliderEvent event, Emitter<ShippingState> emit) async {
    try {
      final response = await homeRepository.geySlidersubData(event.id);
      if (response.status!) {
        // final sliders = response.data;
      }
      emit(ShippingSuccessSliderState(response.data!));
    } catch (e) {}
  }

  void _mapCategory(
      ShippingSubCategoryEvent event, Emitter<ShippingState> emit) async {
    try {
      final response = await homeRepository.getSubCategories(event.id);
      if (response.status!) {
        final category = response;
        print(category);
        print('[[[[[[[[[[[[[[[[[[[[');
        emit(ShippingSuccessSubState(category));
      }
    } catch (e) {
      emit(ShippingErrorSubState(e.toString()));
    }
  }

  void _mapCategoryService(
      ShippingCategoryServiceEvent event, Emitter<ShippingState> emit) async {
    try {
      final response = await homeRepository.getSubCategories(event.id);
      if (response.status!) {
        final category = response;
        print(category.data![0].name);
        print('[[[[[[[[[[[[[[[[[[[[');
        emit(GebServiceCatSuccessStates(category));
      }
    } catch (e) {
      // emit(ShippingErrorSubState(e.toString()));
    }
  }

  void _mapSubCategory(
      ShippingSubSubCategoryEvent event, Emitter<ShippingState> emit) async {
    try {
      final response = await homeRepository.getSubsubCategories(event.id);
      if (response.status!) {
        final category = response;
        print(category);
        print('[[[[[[[[[[[[[[[[[[[[');
        emit(ShippingSuccessSubSubState(category));
      }
    } catch (e) {
      emit(ShippingErrorSubState(e.toString()));
    }
  }

  SubSubCategoryModel? subsubCategoryModel;
}
