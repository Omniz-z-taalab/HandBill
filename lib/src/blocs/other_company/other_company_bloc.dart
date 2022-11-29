import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/repositories/other_company_repository.dart';

import 'other_company_event.dart';
import 'other_company_state.dart';

class OtherCompanyBloc extends Bloc<OtherCompanyEvent, OtherCompanyState> {
  String tag = "OtherCompanyBloc";

  OtherCompanyRepository _otherCompanyRepository = OtherCompanyRepository();
  int shippingPage = 1;
  int customsPage = 1;
  bool isFetching = true;

  OtherCompanyBloc({required BuildContext context})
      : super(OtherCompanyInitialState()) {
    on<FetchShippingCompaniesEvent>(_mapFetchShipping);
    on<FetchCustomsCompaniesEvent>(_mapFetchCustomsCompanies);
  }

  void _mapFetchShipping(FetchShippingCompaniesEvent event,
      Emitter<OtherCompanyState> emit) async {
    emit(OtherCompanyLoadingState());
    final response = await _otherCompanyRepository.getShippingCompanies(
        // page: shippingPage,
        subNature: event.subNature);

    if (response.status!) {
      final items = response.data;
      emit(ShippingSuccessState(items: items));
      shippingPage++;
      isFetching = false;
    } else {
      emit(OtherCompanyErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapFetchCustomsCompanies(
      FetchCustomsCompaniesEvent event, Emitter<OtherCompanyState> emit) async {
    emit(OtherCompanyLoadingState());
    final response =
        await _otherCompanyRepository.getCustomsCompanies(page: customsPage);

    if (response.status!) {
      final items = response.data;
      emit(CustomsCompaniesSuccessState(items: items));
      customsPage++;
      isFetching = false;
    } else {
      emit(OtherCompanyErrorState(error: response.message));
      isFetching = false;
    }
  }
}
