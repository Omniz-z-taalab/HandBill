import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/services/job_user_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/services/jobs/all_jobs_response.dart';
import 'package:hand_bill/src/data/response/services/jobs/jobs_categories_response.dart';
import 'package:hand_bill/src/data/response/services/jobs/my_jobs_response.dart';
import 'package:hand_bill/src/data/response/services/jobs/remove_job_response.dart';
import 'package:hand_bill/src/data/response/auth/common_response.dart';

import '../common/global.dart';

class JobsRepository {
  String tag = "JobsRepository";
  Dio _dio = Dio();
  User? user;

  Future<CompaniesJobsResponse?> getCompaniesJobsData(
      {required int page, int? categoryId, int? subcategoryId}) async {
    String? value = await storage.read(key: "lang");

    Map<String, String> queryParams;
    if (categoryId == null || subcategoryId == null) {
      queryParams = ({
        "language": value!,
        "secret": APIData.secretKey,
        "page": page.toString(),
        "paginate": "6"
      });
    } else {
      queryParams = ({
        "secret": APIData.secretKey,
        "page": page.toString(),
        "paginate": "6",
        "category_id": categoryId.toString(),
        "sub_category_id": subcategoryId.toString()
      });
    }

    late CompaniesJobsResponse jobsResponse;
    Response response;
    try {
      response = await _dio.get(APIData.getCompaniesJobs,
          queryParameters: queryParams);

      log("${jsonEncode(response.data)}");

      jobsResponse = CompaniesJobsResponse.fromJson(response.data);
      if (jobsResponse.status!) {
        return jobsResponse;
      } else {
        return jobsResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return jobsResponse;
  }

  Future<JobsCategoriesResponse?> getJobsCategories() async {
    String? value = await storage.read(key: "lang");

    Map<String, String> queryParams = ({"secret": APIData.secretKey,
    "language": value!});

    late JobsCategoriesResponse jobsCategoriesResponse;
    Response response;
    try {
      response = await _dio.get(APIData.getJobsCategories,
          queryParameters: queryParams);

      log("${jsonEncode(response.data)}");

      jobsCategoriesResponse = JobsCategoriesResponse.fromJson(response.data);
      if (jobsCategoriesResponse.status!) {
        return jobsCategoriesResponse;
      } else {
        return jobsCategoriesResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return jobsCategoriesResponse;
  }

  Future<JobsCategoriesResponse?> getJobsSubCategories(
      {required int id}) async {
    String? value = await storage.read(key: "lang");

    Map<String, String> queryParams =
        ({"secret": APIData.secretKey, "category_id": id.toString(),
        'language':value!});

    late JobsCategoriesResponse jobsCategoriesResponse;
    Response response;
    try {
      response = await _dio.get(APIData.getJobsSubCategories,
          queryParameters: queryParams);

      log("${jsonEncode(response.data)}");

      jobsCategoriesResponse = JobsCategoriesResponse.fromJson(response.data);
      if (jobsCategoriesResponse.status!) {
        return jobsCategoriesResponse;
      } else {
        return jobsCategoriesResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return jobsCategoriesResponse;
  }

  Future<MyJobsResponse?> getMyJobs(
      {required int page, required User user}) async {
    String? value = await storage.read(key: "lang");

    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";
    Map<String, String> queryParams = ({
      "secret": APIData.secretKey,
      "page": page.toString(),
      "paginate": "6",
      "language":value!,

    });

    late MyJobsResponse myJobsResponse;
    Response response;
    try {
      response =
          await _dio.get(APIData.getMyJobs, queryParameters: queryParams);

      log("${jsonEncode(response.data)}");

      myJobsResponse = MyJobsResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return myJobsResponse;
  }

  Future<CommonResponse?> addJob(
      {required JobUserModel model, required User user}) async {
    String? value = await storage.read(key: "lang");

    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";
    FormData formData;

    formData = FormData.fromMap({
      "language":value!,
      "secret": APIData.secretKey,
      "title": model.title,
      "description": model.description,
      "category_id": model.jobCategoryModel!.id,
      "sub_category_id": model.jobSubCategoryModel!.id,
    });
    Response response;

    CommonResponse? commonResponse;

    try {
      response = await _dio.post(APIData.addJob, data: formData);

      log("${jsonEncode(response.data)}");

      commonResponse = CommonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return commonResponse;
  }

  Future<CommonResponse?> removeJob(
      {required JobUserModel model, required User user}) async {
    String? value = await storage.read(key: "lang");

    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";

    Map<String, String> queryParams =
        ({"secret": APIData.secretKey, "id": model.id.toString(),
        "language":value!});
    Response response;

    CommonResponse? commonResponse;

    try {
      response =
          await _dio.delete(APIData.removeJob, queryParameters: queryParams);

      log("${jsonEncode(response.data)}");
      commonResponse = CommonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return commonResponse;
  }
}
