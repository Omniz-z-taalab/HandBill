import 'package:equatable/equatable.dart';

abstract class OffersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch
class FetchOffersEvent extends OffersEvent {}

