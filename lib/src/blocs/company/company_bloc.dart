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

import '../../data/response/search/search_product_response.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  String tag = "CompanyBloc";
  CompanyRepository _companyRepository = CompanyRepository();
  int page = 1;
  bool isFetching = true;
  Company? company;

  CompanyBloc() : super(CompanyInitialState());

  @override
  Stream<CompanyState> mapEventToState(CompanyEvent event) async* {
    if (event is FetchCompanyDetails) {
      yield* _mapFetchCompanyDetails(event);
    }
    if (event is FetchFeaturedProductCompany) {
      yield* _mapFetchFeaturedProductCompany(event);
    }

    if (event is FetchCompanyProducts) {
      yield* _mapCompanyProducts(event);
    }

    if (event is FetchCompanyCategories) {
      yield* _mapCategories(event);
    }
  }

  Stream<CompanyState> _mapFetchCompanyDetails(
      FetchCompanyDetails event) async* {
    yield CompanyLoadingState();
    CompanyDetailsResponse response =
        await _companyRepository.getCompanyDetail(companyId: event.id);
    company = response.data;
    print(company!.name!);
    print('pppp');
    // emit(state);
    if (response.status!) {
      yield GetCompanySuccessState(company: response.data);
    } else {
      yield CompanyErrorState(error: response.message);
    }
  }
  Stream<CompanyState> _mapFetchFeaturedProductCompany(
      FetchFeaturedProductCompany event) async* {
    yield CompanyLoadingState();

    FeaturedProductsResponse response =
    await _companyRepository.getFeaturedProductOfCompany(id: event.id);
    if (response.status!) {
      yield GetFeaturedProductCompanySuccessState(items: response.data);
    } else {
      yield CompanyErrorState(error: response.message);
    }
  }

  Stream<CompanyState> _mapCompanyProducts(FetchCompanyProducts event) async* {
    yield CompanyLoadingState();

    CompanyProductsResponse response = await _companyRepository
        .getCompanyProducts(companyId: event.companyId, page: page);
    if (response.status!) {
      yield GetCompanyProductsSuccessState(items: response.data);
      page++;
      isFetching = false;
    } else {
      yield CompanyErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<CompanyState> _mapCategories(FetchCompanyCategories event) async* {
    yield CompanyLoadingState();
    CompanyCategoriesResponse response =
        await _companyRepository.getCompanyCategories(companyId: event.id);

    if (response.status!) {
      yield GetCompanyCategoriesSuccessState(items: response.data);
    } else {
      yield CompanyErrorState(error: response.message.toString());
    }
  }
}
