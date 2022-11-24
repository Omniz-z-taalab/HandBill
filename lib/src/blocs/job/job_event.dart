import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/services/job_user_model.dart';
import 'package:hand_bill/src/data/model/user.dart';

abstract class JobEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch all
class FetchCompaniesJobsEvent extends JobEvent {
  int? categoryId;
  int? subcategoryId;

  FetchCompaniesJobsEvent({this.categoryId, this.subcategoryId});
}

// fetch job categories
class FetchJobsCategoriesEvent extends JobEvent {}

// fetch job subcategories
class FetchJobsSubcategoriesEvent extends JobEvent {
  final int id;

  FetchJobsSubcategoriesEvent({required this.id});
}

// fetch my
class FetchMyJobsEvent extends JobEvent {
  final User user;

  FetchMyJobsEvent({required this.user});
}

// add
class JobAddEvent extends JobEvent {
  final JobUserModel model;
  final User user;

  JobAddEvent({required this.model, required this.user});
}

// remove
class JobRemoveEvent extends JobEvent {
  final JobUserModel model;
  final User user;

  JobRemoveEvent({required this.user, required this.model});
}
