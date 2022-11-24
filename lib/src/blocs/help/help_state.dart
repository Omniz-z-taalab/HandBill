import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/account_package/agent_model.dart';
import 'package:hand_bill/src/data/model/helpcenterMode/help-model.dart';

abstract class HelpState extends Equatable {
  const HelpState();

  @override
  List<Object> get props => [];
}

class HelpInitialState extends HelpState {}

class HelpLoadingState extends HelpState {}

class HelpErrorState extends HelpState {
  final String? error;

  HelpErrorState({required this.error});
}

// fetch
class AgentSuccessState extends HelpState {
  final List<AgentModel>? items;

  AgentSuccessState({required this.items});
}

class HelpCenterLoading extends HelpState{}
class HelpCenterSuccess extends HelpState{
  final List<HelpCenterModel>? items;
  HelpCenterSuccess({required this.items});

}
class HelpCenterError extends HelpState{}
