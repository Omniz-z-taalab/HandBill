import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/response/home/featured_product_response.dart';
import 'package:hand_bill/src/data/response/market/company_categories_response.dart';
import 'package:hand_bill/src/data/response/market/company_details_response.dart';
import 'package:hand_bill/src/data/response/market/company_product_response.dart';
import 'package:hand_bill/src/repositories/company_repository.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  String tag = "CompanyBloc";
  CompanyRepository _companyRepository = CompanyRepository();
  int page = 1;
  bool isFetching = true;
  Company? company;

  CompanyBloc() : super(CompanyInitialState()) {
    on<FetchCompanyDetails>(_mapFetchCompanyDetails);
    on<FetchFeaturedProductCompany>(_mapFetchFeaturedProductCompany);
    on<FetchCompanyProducts>(_mapCompanyProducts);
    on<FetchCompanyCategories>(_mapCategories);
  }

  void _mapFetchCompanyDetails(
      FetchCompanyDetails event, Emitter<CompanyState> emit) async {
    emit(CompanyLoadingState());
    CompanyDetailsResponse response =
        await _companyRepository.getCompanyDetail(companyId: event.id);
    company = response.data;
    print(company!.name!);
    print('pppp');
    // emit(state);
    if (response.status!) {
      emit(GetCompanySuccessState(company: response.data));
    } else {
      emit(CompanyErrorState(error: response.message));
    }
  }

  void _mapFetchFeaturedProductCompany(
      FetchFeaturedProductCompany event, Emitter<CompanyState> emit) async {
    emit(CompanyLoadingState());

    FeaturedProductsResponse response =
        await _companyRepository.getFeaturedProductOfCompany(id: event.id);
    if (response.status!) {
      emit(GetFeaturedProductCompanySuccessState(items: response.data));
    } else {
      emit(CompanyErrorState(error: response.message));
    }
  }

  void _mapCompanyProducts(
      FetchCompanyProducts event, Emitter<CompanyState> emit) async {
    emit(CompanyLoadingState());

    CompanyProductsResponse response = await _companyRepository
        .getCompanyProducts(companyId: event.companyId, page: page);
    if (response.status!) {
      emit(GetCompanyProductsSuccessState(items: response.data));
      page++;
      isFetching = false;
    } else {
      emit(CompanyErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapCategories(
      FetchCompanyCategories event, Emitter<CompanyState> emit) async {
    emit(CompanyLoadingState());
    CompanyCategoriesResponse response =
        await _companyRepository.getCompanyCategories(companyId: event.id);

    if (response.status!) {
      emit(GetCompanyCategoriesSuccessState(items: response.data));
    } else {
      emit(CompanyErrorState(error: response.message.toString()));
    }
  }
}
