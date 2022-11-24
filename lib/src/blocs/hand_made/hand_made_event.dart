import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/services/handmade_model.dart';
import 'package:hand_bill/src/data/model/user.dart';

abstract class HandmadeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch all
class FetchHandmadeEvent extends HandmadeEvent {}

// fetch my
class FetchMyHandmadeEvent extends HandmadeEvent {
  final User user;

  FetchMyHandmadeEvent({required this.user});
}

// add
class HandmadeAddEvent extends HandmadeEvent {
  final HandmadeModel model;
  final User user;
  final List<Object> images;

  HandmadeAddEvent(
      {required this.model, required this.user, required this.images});
}

// remove
class HandmadeRemoveEvent extends HandmadeEvent {
  final HandmadeModel model;
  final User user;

  HandmadeRemoveEvent({required this.user, required this.model});
}
