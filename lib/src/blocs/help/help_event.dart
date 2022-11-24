import 'package:equatable/equatable.dart';

abstract class HelpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch
class FetchAgentEvent extends HelpEvent {}
class HelpCenterEvent extends HelpEvent {}

