import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/services/job_category_model.dart';
import 'package:hand_bill/src/data/model/services/job_company_model.dart';
import 'package:hand_bill/src/data/model/services/job_user_model.dart';

abstract class JobsState extends Equatable {
  const JobsState();

  @override
  List<Object> get props => [];
}

class JobInitialState extends JobsState {}

class JobLoadingState extends JobsState {}

class JobErrorState extends JobsState {
  final String? error;

  JobErrorState({required this.error});
}

// fetch
class CompanyJobSuccessState extends JobsState {
  final List<JobCompanyModel>? items;

  CompanyJobSuccessState({required this.items});
}

// get categories
class JobCategoriesSuccessState extends JobsState {
  final List<JobCategoryModel>? items;

  JobCategoriesSuccessState({required this.items});
}

// get subcategories
class JobSubcategoriesSuccessState extends JobsState {
  final List<JobCategoryModel>? items;

  JobSubcategoriesSuccessState({required this.items});
}

// fetch my
class MyJobSuccessState extends JobsState {
  final List<JobUserModel>? items;

  MyJobSuccessState({required this.items});
}

// add
class JobAddSuccessState extends JobsState {
  final String? message;

  JobAddSuccessState({required this.message});
}

// remove
class JobRemoveSuccessState extends JobsState {
  final String? message;
  final JobUserModel model;

  JobRemoveSuccessState({required this.message, required this.model});
}
