import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/home/categories_response.dart';
import 'package:hand_bill/src/data/response/home/sub_categories_response.dart';

import '../common/global.dart';

class CategoryRepository {
  String tag = "CategoryRepository";
  Dio _dio = Dio();

  Future<CategoriesResponse> getCategoriesData() async {
    String? value = await storage.read(key: "lang");

    var queryParameters = {"secret": APIData.secretKey,"language": value};
    CategoriesResponse? categoriesResponse;
    Response response;
    try {
      response = await _dio.get(APIData.getCategories,
          queryParameters: queryParameters);
      categoriesResponse = CategoriesResponse.fromJson(response.data);
      log("getCategoriesData: ${jsonEncode(response.data)}");
      if (categoriesResponse.status!) {
        return categoriesResponse;
      } else {
        return categoriesResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return categoriesResponse!;
  }

  Future<SubCategoriesResponse> getSubCategoriesData(
      {required String categoryId, required int page}) async {
    String? value = await storage.read(key: "lang");
    var queryParameters = {
      "language": value,
      "secret": APIData.secretKey,
      "category_id": categoryId,
      "paginate": "6",
      "page": "$page"
    };
    SubCategoriesResponse? subCategoryResponse;
    Response response;
    try {
      response = await _dio.get(APIData.getSubCategories,
          queryParameters: queryParameters);
      subCategoryResponse = SubCategoriesResponse.fromJson(response.data);
      return subCategoryResponse;
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return subCategoryResponse!;
  }
}
