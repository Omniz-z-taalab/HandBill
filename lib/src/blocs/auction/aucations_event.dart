import 'package:equatable/equatable.dart';

abstract class AuctionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch
class FetchAuctionsEvent extends AuctionsEvent {}

