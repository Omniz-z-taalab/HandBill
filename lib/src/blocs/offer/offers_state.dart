import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/services/auction_model.dart';
import 'package:hand_bill/src/data/model/services/offer_model.dart';

abstract class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object> get props => [];
}

class OffersInitialState extends OffersState {}

class OffersLoadingState extends OffersState {}

class OffersErrorState extends OffersState {
  final String? error;

  OffersErrorState({required this.error});
}

// fetch
class OffersSuccessState extends OffersState {
  final List<OfferModel>? items;

  OffersSuccessState({required this.items});
}
