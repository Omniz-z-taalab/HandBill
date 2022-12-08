import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/global.dart';
import 'package:hand_bill/src/data/response/search/search_categories_response.dart';
import 'package:hand_bill/src/data/response/search/search_companies_response.dart';
import 'package:hand_bill/src/data/response/search/search_product_response.dart';

import '../data/model/Search_data.dart';
import '../data/model/category/sub_sub.dart';
import '../data/response/banner/banner_service_response.dart';
import '../data/response/home/serviceCategory_reponse.dart';
import '../data/response/product/products_response.dart';
import '../data/response/search/Search_sub_sub.dart';
import '../data/response/search/search_sub_categorie.dart';

class SearchRepository {
  String tag = "SearchRepository";
  var dio = Dio();

  Future<SearchProductResponse> getSearchProducts(String search) async {
    String? value = await storage.read(key: "lang");
    print(value);
    print('omnisssss');
    Map<String, dynamic> queryParams = ({
      // "secret": APIData.secretKey,
      "search": '$search',
      "language": value
    });

    late SearchProductResponse searchResponse;
    Response response;
    try {
      response =

      await dio.get(APIData.searchProduct,queryParameters: queryParams);
      log("sss: ${jsonEncode(response.data)}");
      print(response.data);
      searchResponse = SearchProductResponse.fromJson(response.data);
      print(searchResponse.data);
      if (searchResponse.status!) {
        return searchResponse;
      } else {
        return searchResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return searchResponse;
  }

  // Future<SubSubCategoryModel> getSubsubCategories() async {
  //   String? value = await storage.read(key: "lang");
  //   // print(id);
  //   Map<String, dynamic> queryParams =
  //       ({"secret": APIData.secretKey, "language": value});
  //
  //   SubSubCategoryModel? subCategoryModel;
  //   Response response =
  //       await dio.get(APIData.getSubsubCategory, queryParameters: queryParams);
  //   subCategoryModel = SubSubCategoryModel.fromJson(response.data);
  //   print(response.data);
  //   return subCategoryModel;
  //   // emit(GetSubSubCatSuccessStates());
  // }

  Future<SearchCompaniesResponse?> getSearchCompanies(String search) async {
    String? value = await storage.read(key: "lang");

    Map<String, dynamic> queryParams =
        ({"search": '$search', "language": value});

    SearchCompaniesResponse? companyResponse;
    try {
      Response? response =
          await dio.get(APIData.searchCompanies, queryParameters: queryParams);
      log("getSearchCompanies: ${jsonEncode(response.data)}");

      companyResponse = SearchCompaniesResponse.fromJson(response.data);
      // print(companyResponse.data!.first.name);
    } catch (error, stackTrace) {
      companyResponse == null;
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return companyResponse;
  }

  // Future<SearchCompaniesResponse> getServiceCompanies(int search) async {
  //   String? value = await storage.read(key: "lang");
  //   print(value);
  //   print('languageeee');
  //   Map<String, dynamic> queryParams =
  //   ({ "category_id": '$search',
  //     "language": value
  //   });
  //
  //   late SearchCompaniesResponse companyResponse;
  //   try {
  //     Response response =
  //     await dio.get(APIData.searchCompanies, queryParameters: queryParams);
  //     log("getSearchCompanies: ${jsonEncode(response.data)}");
  //
  //     companyResponse = SearchCompaniesResponse.fromJson(response.data);
  //     // print(companyResponse.data!.first.name);
  //     if (companyResponse.data != null) {
  //       return companyResponse;
  //     } else {
  //       return companyResponse;
  //     }
  //   } catch (error, stackTrace) {
  //     print("$tag error : $error , stackTrace:  $stackTrace");
  //   }
  //   return companyResponse;
  // }

  // Future<ServiceResponse> getCategoryCompanies() async {
  //   var queryParameters = {"secret": APIData.secretKey,
  //     "language": "lang"
  //   };
  //    ServiceResponse? serviceResponse;
  //   Response response;
  //
  //   try {
  //      response =
  //     await dio.get(APIData.getCompanyCategories,queryParameters: queryParameters);
  //
  //     serviceResponse = ServiceResponse.fromJson(response.data);
  //      log("getSearchCompanies:[ ${jsonEncode(response.data)}]");
  //      // print(serviceResponse.data!.first.name);
  //     if (serviceResponse.status!) {
  //       return serviceResponse;
  //     } else {
  //       return serviceResponse;
  //     }
  //   } catch (error, stackTrace) {
  //     print("$tag error : $error , stackTrace:  $stackTrace");
  //   }
  //   return serviceResponse!;
  // }
  Future<SearchCategoriesResponse> getAllCategories() async {
    String? value = await storage.read(key: "lang");
    print(value);
    print('languageeee');
    Map<String, dynamic> queryParams = ({"language": value});

    late SearchCategoriesResponse searchCategoriesResponse;
    try {
      Response response =
          await dio.get(APIData.searchCategories, queryParameters: queryParams);
      log("getSearchCategories: ${jsonEncode(response.data)}");
      searchCategoriesResponse =
          SearchCategoriesResponse.fromJson(response.data);
      if (searchCategoriesResponse.status == true) {
        print('dddddeeee');
        print(searchCategoriesResponse.data!.first.name);
        return searchCategoriesResponse;
      } else {
        return searchCategoriesResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return searchCategoriesResponse;
  }

  Future<SearchSubCategoriesResponse> getAllSubCategories(int id) async {
    String? value = await storage.read(key: "lang");

    Map<String, dynamic> queryParams = ({"id": '$id', "language": value});

    late SearchSubCategoriesResponse searchCategoriesResponse;
    try {
      Response response = await dio.get(APIData.searchSubCategories,
          queryParameters: queryParams);
      log("getSearchSubSubCategories: ${jsonEncode(response.data)}");

      searchCategoriesResponse =
          SearchSubCategoriesResponse.fromJson(response.data);
      if (searchCategoriesResponse.status!) {
        return searchCategoriesResponse;
      } else {
        return searchCategoriesResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return searchCategoriesResponse;
  }

  Future<SearchSubSubCategoriesResponse> getSubSubCategories(int id) async {
    String? value = await storage.read(key: "lang");

    Map<String, dynamic> queryParams = ({"id": '$id', "language": value});

    late SearchSubSubCategoriesResponse searchSubSubCategoriesResponse;
    try {
      Response response = await dio.get(APIData.searchSubSubCategories,
          queryParameters: queryParams);
      log("getSearchSubCategories: ${jsonEncode(response.data)}");

      searchSubSubCategoriesResponse =
          SearchSubSubCategoriesResponse.fromJson(response.data);
      if (searchSubSubCategoriesResponse.status!) {
        return searchSubSubCategoriesResponse;
      } else {
        return searchSubSubCategoriesResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return searchSubSubCategoriesResponse;
  }

  List<Map<String, dynamic>> map = [];

  Future<ProductsResponse> getSearchProduct(int id) async {
    String? value = await storage.read(key: "lang");

    Map<String, dynamic> queryParams =
        ({"language": value, "sub_sub_category_id": id});
    ProductsResponse searchProductResponse;
    Response response = await dio.get(APIData.productDetailss, queryParameters: queryParams);
    searchProductResponse = ProductsResponse.fromJson(response.data);
    print(response.data);
    return searchProductResponse;
  }
}
