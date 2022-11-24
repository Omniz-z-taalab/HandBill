import 'dart:async';

import 'package:bloc/bloc.dart';
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
  }

  @override
  Stream<JobsState> mapEventToState(JobEvent event) async* {
    if (event is FetchCompaniesJobsEvent) {
      yield* _mapFetchJobs(event);
    }
    if (event is FetchMyJobsEvent) {
      yield* _mapFetchMyJobs(event);
    }

    if (event is FetchJobsCategoriesEvent) {
      yield* _mapFetchJobsCategories(event);
    }

    // categories
    if (event is FetchJobsCategoriesEvent) {
      yield* _mapFetchJobsCategories(event);
    }
    // subcategories
    if (event is FetchJobsSubcategoriesEvent) {
      yield* _mapFetchJobsSubCategories(event);
    }
    if (event is JobAddEvent) {
      yield* _mapAddJob(event);
    }
    if (event is JobRemoveEvent) {
      yield* _mapRemoveJob(event);
    }
  }

  Stream<JobsState> _mapFetchJobs(FetchCompaniesJobsEvent event) async* {
    yield JobLoadingState();
    final response = await _jobsRepository.getCompaniesJobsData(
        page: allPage,
        categoryId: event.categoryId,
        subcategoryId: event.subcategoryId);
    if (response!.status!) {
      final items = response.data;
      yield CompanyJobSuccessState(items: items);
      allPage++;
      isFetching = false;
    } else {
      yield JobErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<JobsState> _mapFetchMyJobs(FetchMyJobsEvent event) async* {
    yield JobLoadingState();
    final response =
        await _jobsRepository.getMyJobs(page: myPage, user: event.user);

    if (response!.status!) {
      final items = response.data;
      yield MyJobSuccessState(items: items);
      myPage++;
      isFetching = false;
    } else {
      yield JobErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<JobsState> _mapFetchJobsCategories(
      FetchJobsCategoriesEvent event) async* {
    yield JobLoadingState();
    final response = await _jobsRepository.getJobsCategories();

    if (response!.status!) {
      final items = response.data;
      yield JobCategoriesSuccessState(items: items);
      isFetching = false;
    } else {
      yield JobErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<JobsState> _mapFetchJobsSubCategories(
      FetchJobsSubcategoriesEvent event) async* {
    yield JobLoadingState();
    final response = await _jobsRepository.getJobsSubCategories(id: event.id);

    if (response!.status!) {
      final items = response.data;
      yield JobSubcategoriesSuccessState(items: items);
      isFetching = false;
    } else {
      yield JobErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<JobsState> _mapAddJob(JobAddEvent event) async* {
    yield JobLoadingState();
    final response =
        await _jobsRepository.addJob(model: event.model, user: event.user);

    if (response!.status!) {
      yield JobAddSuccessState(message: response.message!);
      isFetching = false;
    } else {
      yield JobErrorState(error: response.message);
      isFetching = false;
    }
  }

  Stream<JobsState> _mapRemoveJob(JobRemoveEvent event) async* {
    yield JobLoadingState();
    final response =
        await _jobsRepository.removeJob(model: event.model, user: event.user);

    if (response!.status!) {
      yield JobRemoveSuccessState(
          message: response.message!, model: event.model);
      isFetching = false;
    } else {
      yield JobErrorState(error: response.message);
      isFetching = false;
    }
  }
}
