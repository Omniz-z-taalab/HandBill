part of 'company_bloc.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object> get props => [];
}

class CompanyInitialState extends CompanyState {}

class CompanyLoadingState extends CompanyState {}

class CompanyErrorState extends CompanyState {
  final String? error;

  CompanyErrorState({required this.error});
}

// fetch details
class GetCompanySuccessState extends CompanyState {
  final Company? company;

  GetCompanySuccessState({required this.company});
}

// fetch featured
class GetFeaturedProductCompanySuccessState extends CompanyState {
  final List<Product>? items;

  GetFeaturedProductCompanySuccessState({required this.items});
}

////  Categories
class GetCompanyCategoriesSuccessState extends CompanyState {
  final List<CategoryModel>? items;

  const GetCompanyCategoriesSuccessState({required this.items});
}

// fetch product
class GetCompanyProductsSuccessState extends CompanyState {
  final List<Product>? items;

  GetCompanyProductsSuccessState({required this.items});
}
