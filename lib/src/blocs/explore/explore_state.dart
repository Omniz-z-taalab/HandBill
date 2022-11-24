import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/explore_model.dart';
import 'package:hand_bill/src/data/model/services/assets_model.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitialState extends ExploreState {}

class ExploreLoadingState extends ExploreState {}

class ExploreErrorState extends ExploreState {
  final String? error;

  ExploreErrorState({required this.error});
}

// fetch
class ExploreSuccessState extends ExploreState {
  final List<ExploreModel>? items;

  ExploreSuccessState({required this.items});
}
