import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/services/auction_model.dart';

abstract class AuctionsState extends Equatable {
  const AuctionsState();

  @override
  List<Object> get props => [];
}

class AuctionsInitialState extends AuctionsState {}

class AuctionsLoadingState extends AuctionsState {}

class AuctionsErrorState extends AuctionsState {
  final String? error;

  AuctionsErrorState({required this.error});
}

// fetch
class AuctionsSuccessState extends AuctionsState {
  final List<AuctionModel>? items;

  AuctionsSuccessState({required this.items});
}
