import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../common/api_data.dart';
import '../common/global.dart';
import '../data/model/serviceCategories_model.dart';
import '../data/response/home/serviceCategory_reponse.dart';
import '../data/response/search/search_companies_response.dart';

class ServiceRepository {
  Dio _dio = Dio();

  // Future<void> getWalletAmount() async {
  //  var queryParameters = {"secret": APIData.secretKey};
  //   //   CategoriesResponse? categoriesResponse;
  //   //   Response response;
  //   //   try {
  //   //     response = await _dio.get(APIData.getCategories,
  //   //         queryParameters: queryParameters);
  //   //     categoriesResponse = CategoriesResponse.fromJson(response.data);
  //   //     log("getCategoriesData: ${jsonEncode(response.data)}");
  //   //     if (categoriesResponse.status!) {
  //   //       return categoriesResponse;
  //   //     } else {
  //   //       return categoriesResponse;
  //   //     }
  //   //   } catch (error, stackTrace) {
  //   //     print("$tag error : $error , stackTrace:  $stackTrace");
  //   //   }
  //   //   return categoriesResponse!;
  //   // }

  // }

  String tag = "ServiceRepository";

  Future<SearchCompaniesResponse> getSearchCompanies(String search) async {
    String? value = await storage.read(key: "lang");
    Map<String, String> queryParams =
    ({ "search": '$search',
    "language": value!
    });

    late SearchCompaniesResponse companyResponse;
    try {
      Response response =
      await _dio.get(APIData.searchCompanies, queryParameters: queryParams);
      log("getSearchCompanies: ${jsonEncode(response.data)}");

      companyResponse = SearchCompaniesResponse.fromJson(response.data);
      print(companyResponse.data!.first.name);
      if (companyResponse.data != null) {
        return companyResponse;
      } else {
        return companyResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return companyResponse;
  }

  Future<ServiceCategoryModel> getServicesData() async {
    String? value = await storage.read(key: "lang");
    var queryParameters = {"secret": APIData.secretKey,"language":value};
    ServiceCategoryModel? serviceResponse;
    Response response;
    try {
      response = await _dio.get(APIData.getCompanyCategories,
          queryParameters: queryParameters);
      serviceResponse = ServiceCategoryModel.fromJson(response.data);
      log("dtaaaaaaaaaaaaa: ${jsonEncode(response.data)}");
      if (serviceResponse.status!) {
        return serviceResponse;
      } else {
        return serviceResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return serviceResponse!;
  }

  Future<ServicecategoryResponse> ServicesData() async {
    String? value = await storage.read(key: "lang");
    var queryParameters = {"secret": APIData.secretKey,"language": value};
    ServicecategoryResponse? serviceResponse;
    Response response;
    try {
      response = await _dio.get(APIData.getCompanyCategories,
          queryParameters: queryParameters);
      serviceResponse = ServicecategoryResponse.fromJson(response.data);
      log("dtaaaaaaaaaaaaa: ${jsonEncode(response.data)}");
      if (serviceResponse.status!) {
        return serviceResponse;
      } else {
        return serviceResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return serviceResponse!;
  }

}
