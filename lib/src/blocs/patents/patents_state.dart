import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/services/patented_model.dart';

abstract class PatentsState extends Equatable {
  const PatentsState();

  @override
  List<Object> get props => [];
}

class PatentsInitialState extends PatentsState {}

class PatentsLoadingState extends PatentsState {}

class PatentsErrorState extends PatentsState {
  final String? error;

  PatentsErrorState({required this.error});
}

// fetch all
class PatentsSuccessState extends PatentsState {
  final List<PatentedModel>? items;

  PatentsSuccessState({required this.items});
}

// fetch my
class MyPatentsSuccessState extends PatentsState {
  final List<PatentedModel>? items;

  MyPatentsSuccessState({required this.items}){
    // print(items!.first);
  }
}

// add
class PatentedAddSuccessState extends PatentsState {
  final String message;

  PatentedAddSuccessState({required this.message});
}

// remove
class PatentedRemoveSuccessState extends PatentsState {
  final String? message;
  final PatentedModel model;

  PatentedRemoveSuccessState({required this.message, required this.model});
}
