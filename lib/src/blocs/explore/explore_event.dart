import 'package:equatable/equatable.dart';

abstract class ExploreEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch
class FetchExploreEvent extends ExploreEvent {}

