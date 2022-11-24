import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/company.dart';

abstract class OtherCompanyState extends Equatable {
  const OtherCompanyState();

  @override
  List<Object> get props => [];
}

class OtherCompanyInitialState extends OtherCompanyState {}

class OtherCompanyLoadingState extends OtherCompanyState {}

class OtherCompanyErrorState extends OtherCompanyState {
  final String? error;

  OtherCompanyErrorState({required this.error});
}

// fetch
class ShippingSuccessState extends OtherCompanyState {
  final List<Company>? items;

  ShippingSuccessState({required this.items});
}
// fetch
class CustomsCompaniesSuccessState extends OtherCompanyState {
  final List<Company>? items;

  CustomsCompaniesSuccessState({required this.items});
}
