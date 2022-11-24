import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeFetchSliders extends HomeEvent {}

class HomeFetchTopCompanies extends HomeEvent {}

class HomeFetchPopular extends HomeEvent {}

class FetchAllHomeData extends HomeEvent {}

