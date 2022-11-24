import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/services/assets_model.dart';

abstract class AssetsState extends Equatable {
  const AssetsState();

  @override
  List<Object> get props => [];
}

class AssetsInitialState extends AssetsState {}

class AssetsLoadingState extends AssetsState {}

class AssetsErrorState extends AssetsState {
  final String? error;

  AssetsErrorState({required this.error});
}

// fetch
class AssetsSuccessState extends AssetsState {
  final List<AssetsModel>? items;

  AssetsSuccessState({required this.items}){
    print(items!.first.title);
  }
}
