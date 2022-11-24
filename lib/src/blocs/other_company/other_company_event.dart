import 'package:equatable/equatable.dart';

abstract class OtherCompanyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch
class FetchShippingCompaniesEvent extends OtherCompanyEvent {
  final String subNature;

  FetchShippingCompaniesEvent({required this.subNature});

  @override
  List<Object> get props => [subNature];
}

// fetch
class FetchCustomsCompaniesEvent extends OtherCompanyEvent {}
