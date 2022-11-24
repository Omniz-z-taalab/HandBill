import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/services/patented_model.dart';
import 'package:hand_bill/src/data/model/user.dart';

abstract class PatentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch all
class FetchPatentsEvent extends PatentsEvent {}

// fetch my
class FetchMyPatentsEvent extends PatentsEvent {
  final User user;

  FetchMyPatentsEvent({required this.user});
}

// add
class PatentedAddEvent extends PatentsEvent {
  final PatentedModel model;
  final User user;
  final List<Object> images;

  PatentedAddEvent(
      {required this.images, required this.model, required this.user});
}

// remove
class PatentedRemoveEvent extends PatentsEvent {
  final PatentedModel model;
  final User user;

  PatentedRemoveEvent({required this.user, required this.model});
}
