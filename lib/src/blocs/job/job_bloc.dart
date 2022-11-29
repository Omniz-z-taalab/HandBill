import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/repositories/jobs_repository.dart';

import 'job_event.dart';
import 'job_state.dart';

class JobsBloc extends Bloc<JobEvent, JobsState> {
  String tag = "JobBloc";

  JobsRepository _jobsRepository = JobsRepository();
  int allPage = 1;
  int myPage = 1;
  bool isFetching = true;

  JobsBloc({required BuildContext context}) : super(JobInitialState()) {
    _jobsRepository.user = BlocProvider.of<GlobalBloc>(context).user;

    on<FetchCompaniesJobsEvent>(_mapFetchJobs);
    on<FetchMyJobsEvent>(_mapFetchMyJobs);
    on<FetchJobsCategoriesEvent>(_mapFetchJobsCategories);
    on<FetchJobsSubcategoriesEvent>(_mapFetchJobsSubCategories);
    on<JobAddEvent>(_mapAddJob);
    on<JobRemoveEvent>(_mapRemoveJob);
  }

  void _mapFetchJobs(
      FetchCompaniesJobsEvent event, Emitter<JobsState> emit) async {
    emit(JobLoadingState());
    final response = await _jobsRepository.getCompaniesJobsData(
        page: allPage,
        categoryId: event.categoryId,
        subcategoryId: event.subcategoryId);
    if (response!.status!) {
      final items = response.data;
      emit(CompanyJobSuccessState(items: items));
      allPage++;
      isFetching = false;
    } else {
      emit(JobErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapFetchMyJobs(FetchMyJobsEvent event, Emitter<JobsState> emit) async {
    emit(JobLoadingState());
    final response =
        await _jobsRepository.getMyJobs(page: myPage, user: event.user);

    if (response!.status!) {
      final items = response.data;
      emit(MyJobSuccessState(items: items));
      myPage++;
      isFetching = false;
    } else {
      emit(JobErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapFetchJobsCategories(
      FetchJobsCategoriesEvent event, Emitter<JobsState> emit) async {
    emit(JobLoadingState());
    final response = await _jobsRepository.getJobsCategories();

    if (response!.status!) {
      final items = response.data;
      emit(JobCategoriesSuccessState(items: items));
      isFetching = false;
    } else {
      emit(JobErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapFetchJobsSubCategories(
      FetchJobsSubcategoriesEvent event, Emitter<JobsState> emit) async {
    emit(JobLoadingState());
    final response = await _jobsRepository.getJobsSubCategories(id: event.id);

    if (response!.status!) {
      final items = response.data;
      emit(JobSubcategoriesSuccessState(items: items));
      isFetching = false;
    } else {
      emit(JobErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapAddJob(JobAddEvent event, Emitter<JobsState> emit) async {
    emit(JobLoadingState());
    final response =
        await _jobsRepository.addJob(model: event.model, user: event.user);

    if (response!.status!) {
      emit(JobAddSuccessState(message: response.message!));
      isFetching = false;
    } else {
      emit(JobErrorState(error: response.message));
      isFetching = false;
    }
  }

  void _mapRemoveJob(JobRemoveEvent event, Emitter<JobsState> emit) async {
    emit(JobLoadingState());
    final response =
        await _jobsRepository.removeJob(model: event.model, user: event.user);

    if (response!.status!) {
      emit(JobRemoveSuccessState(
          message: response.message!, model: event.model));
      isFetching = false;
    } else {
      emit(JobErrorState(error: response.message));
      isFetching = false;
    }
  }
}
