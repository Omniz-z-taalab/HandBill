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
      : super(OtherCompanyInitialState());

  @override
  Stream<OtherCompanyState> mapEventToState(OtherCompanyEvent event) async* {
    if (event is FetchShippingCompaniesEvent) {
      yield* _mapFetchShipping(
          FetchShippingCompaniesEvent(subNature: event.subNature));
    }
    if (event is FetchCustomsCompaniesEvent) {
      yield* _mapFetchCustomsCompanies();
    }
  }

  Stream<OtherCompanyState> _mapFetchShipping(
      FetchShippingCompaniesEvent event) async* {
    yield OtherCompanyLoadingState();
    final response = await _otherCompanyRepository.getShippingCompanies(
        // page: shippingPage,
        subNature: event.subNature);

    if (response.status!) {
      final items = response.data;
      yield ShippingSuccessState(items: items);
      shippingPage++;
      isFetching = false;
    } else {
      yield OtherCompanyErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<OtherCompanyState> _mapFetchCustomsCompanies() async* {
    yield OtherCompanyLoadingState();
    final response =
        await _otherCompanyRepository.getCustomsCompanies(page: customsPage);

    if (response.status!) {
      final items = response.data;
      yield CustomsCompaniesSuccessState(items: items);
      customsPage++;
      isFetching = false;
    } else {
      yield OtherCompanyErrorState(error: response.message);
      isFetching = false;
    }
  }
}
