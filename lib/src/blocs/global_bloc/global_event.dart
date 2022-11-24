part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object?> get props => [];
}

class StartAppEvent extends GlobalEvent {}
class SaveLanguageEvent extends GlobalEvent {}


class UserStatusChangeEvent extends GlobalEvent {}

