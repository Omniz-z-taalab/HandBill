part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

////  Sliders
class SliderLoadingState extends HomeState {}

class SliderSuccessState extends HomeState {
  final List<BannerModel>? items;

  const SliderSuccessState({required this.items});
}

class SliderErrorState extends HomeState {
  final String errors;

  const SliderErrorState({required this.errors});
}

////  top  companies
class TopCompaniesLoadingState extends HomeState {}

class TopCompaniesSuccessState extends HomeState {
  final List<Company>? items;

  const TopCompaniesSuccessState({required this.items});
}

class TopCompaniesErrorState extends HomeState {
  final String errors;

  const TopCompaniesErrorState({required this.errors});
}

////  Popular
class PopularLoadingState extends HomeState {}

class PopularSuccessState extends HomeState {
  final List<Product>? items;

  const PopularSuccessState({required this.items});
}

class PopularErrorState extends HomeState {
  final String errors;

  const PopularErrorState({required this.errors});
}
