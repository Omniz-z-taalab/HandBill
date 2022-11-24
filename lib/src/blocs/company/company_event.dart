part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

class FetchCompanyDetails extends CompanyEvent {
  final String id;

  FetchCompanyDetails({required this.id});
}

class FetchFeaturedProductCompany extends CompanyEvent {
  final String id;

  FetchFeaturedProductCompany({required this.id});
}

class FetchCompanyCategories extends CompanyEvent {
  final String id;

  FetchCompanyCategories({required this.id});
}

class FetchCompanyProducts extends CompanyEvent {
  final String companyId;


  FetchCompanyProducts({required this.companyId});
}
