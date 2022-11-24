import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/services/handmade_model.dart';

abstract class HandmadeState extends Equatable {
  const HandmadeState();

  @override
  List<Object> get props => [];
}

class HandmadeInitialState extends HandmadeState {}

class HandmadeLoadingState extends HandmadeState {}

class HandmadeErrorState extends HandmadeState {
  final String? error;

  HandmadeErrorState({required this.error});
}

// fetch all
class HandmadeSuccessState extends HandmadeState {
  final List<HandmadeModel>? items;

  HandmadeSuccessState({required this.items});
}

// fetch my
class MyHandmadeSuccessState extends HandmadeState {
  final List<HandmadeModel>? items;

  MyHandmadeSuccessState({required this.items}){
}
}

// add
class HandmadeAddSuccessState extends HandmadeState {
  final String message;

  HandmadeAddSuccessState({required this.message});
}

// remove
class HandmadeRemoveSuccessState extends HandmadeState {
  final String? message;
  final HandmadeModel model;

  HandmadeRemoveSuccessState({required this.message, required this.model});
}
