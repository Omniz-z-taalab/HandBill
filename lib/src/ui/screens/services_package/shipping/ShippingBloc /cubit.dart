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

  ShippingBloc() : super(ShippingInitState());
  List<DataPro> sliders = [];

  Dio _dio = Dio();

  Future<void> getdata() async {}

  // CompanyModel? companyModel;

  Stream<ShippingState> mapEventToState(ShippingInitEvent event) async* {
    if (event is ShippingSliderEvent) {
      yield* _mapFetchSlider(event);
    }
    if (event is ShippingSubCategoryEvent) {
       yield* _mapCategory(event);
    }
    if(event is ShippingSubSubCategoryEvent){
      yield* _mapSubCategory(event);
    }
    if(event is ShippingSliderServiceEvent){
      yield* _mapBannerCompanies();
    }
    if(event is ShippingCategoryServiceEvent){
      yield* _mapCategoryService(event);
    }
  }

  CompanyModel? companyModel;

  Stream<ShippingState> _mapBannerCompanies() async* {
    yield BannerCompanyLoadingState();

    final response =
    await homeRepository.geySliderServiceData();
    try {
      if (response.data != null) {
        final banner = response.data;
        yield BannerCompanySuccessState(banner);
      } else {
        // yield SearchCompaniesErrorState(error: response.message.toString());
      }
    } catch (err) {
      yield BannerCompaniesErrorState(err.toString());
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

  Stream<ShippingState> _mapFetchSlider(ShippingSliderEvent event) async* {
    try {
      final response = await homeRepository.geySlidersubData(event.id);
      if (response.status!) {
        // final sliders = response.data;
      }
      yield ShippingSuccessSliderState(response.data!);
    } catch (e) {}
  }

  Stream<ShippingState> _mapCategory(ShippingSubCategoryEvent event) async* {
    try {
      final response = await homeRepository.getSubCategories(event.id);
      if (response.status!) {
        final category = response;
        print(category);
        print('[[[[[[[[[[[[[[[[[[[[');
        yield ShippingSuccessSubState(category);
      }
    } catch (e) {
      yield ShippingErrorSubState(e.toString());
    }
  }
  Stream<ShippingState> _mapCategoryService(ShippingCategoryServiceEvent event) async* {
    try {
      final response = await homeRepository.getSubCategories(event.id);
      if (response.status!) {
        final category = response;
        print(category.data![0].name);
        print('[[[[[[[[[[[[[[[[[[[[');
        yield GebServiceCatSuccessStates(category);
      }
    } catch (e) {
      // yield ShippingErrorSubState(e.toString());
    }
  }

  Stream<ShippingState> _mapSubCategory(ShippingSubSubCategoryEvent event) async* {
    try {
      final response = await homeRepository.getSubsubCategories(event.id);
      if (response.status!) {
        final category = response;
        print(category);
        print('[[[[[[[[[[[[[[[[[[[[');
        yield ShippingSuccessSubSubState(category);
      }
    } catch (e) {
      yield ShippingErrorSubState(e.toString());
    }
  }


  SubSubCategoryModel? subsubCategoryModel;

}
