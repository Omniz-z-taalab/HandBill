import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/blocs/auth/auth_event.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/common/global.dart';
import 'package:hand_bill/src/data/response/home/top_banner_response.dart';
import 'package:hand_bill/src/data/response/home/top_company_respons.dart';
import 'package:hand_bill/src/data/response/home/top_products_response.dart';

import 'package:http/http.dart' as http;

import '../data/model/category/sub.dart';
import '../data/model/category/sub_sub.dart';
import '../data/response/banner/banner_service_response.dart';
import '../data/response/banner/sub_product.dart';
import '../data/response/services/Service_company_response/service_company_response.dart';

class HomeRepository {
  String tag = "HomeRepository";
  Dio _dio = Dio();

  Future<BannerSubResponse> geySlidersubData(String? id) async {
    String? value = await storage.read(key: "lang");
    print('yaaaaaa');
    print('yaaaaaa');
    // print(event.id);
    var queryParameters = {"secret": APIData.secretKey,
      "language": value,
      'id': id
    };
    BannerSubResponse? bannerSubResponse;
    try {
      Response response =
      await _dio.get(
          APIData.CategoryProductBanner, queryParameters: queryParameters);
      print("geySliderData: ${jsonEncode(response.data)}");
      bannerSubResponse = BannerSubResponse.fromJson(response.data);

      return bannerSubResponse;
      // sliders = sliderResponse.data!;
      // print(sliders);
      // emit(ShippingSuccessSliderState(sliders));
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return bannerSubResponse!;
  }
  Future<BannerServiceResponse> geySliderServiceData() async {
    String? value = await storage.read(key: "lang");
    print('yaaaaaa');
    print('yaaaaaa');
    // print(event.id);
    var queryParameters = {"secret": APIData.secretKey,
      "language": value,
    };
    BannerServiceResponse? bannerSubResponse;
    try {
      Response response =
      await _dio.get(
          APIData.ServiceBanner, queryParameters: queryParameters);
      print("geySliderData: ${jsonEncode(response.data)}");
      bannerSubResponse = BannerServiceResponse.fromJson(response.data);

      return bannerSubResponse;
      // sliders = sliderResponse.data!;
      // print(sliders);
      // emit(ShippingSuccessSliderState(sliders));
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return bannerSubResponse!;
  }

  Future<SubCategoryModel> getSubCategories(String? id) async {
    String? value = await storage.read(key: "lang");
    print(id.toString());
    Map<String, dynamic> queryParams = ({
      // "secret": APIData.secretKey,
      "id": id,
      "language":value
    });
    SubCategoryModel subCategoryModel;
    Response response = await _dio.get(APIData.getSubCategory, queryParameters: queryParams);
      subCategoryModel = SubCategoryModel.fromJson(response.data);
      return subCategoryModel;
  }

  Future<ServiceCompanyResponse> getServiceCompany(String? id) async {
    String? value = await storage.read(key: "lang");
    print(id.toString());
    Map<String, dynamic> queryParams = ({
      "language":value
    });
    ServiceCompanyResponse serviceCompanyResponse;
    Response response = await _dio.get('${APIData.getShippingCompanies}${id}', queryParameters: queryParams);
    serviceCompanyResponse = ServiceCompanyResponse.fromJson(response.data);
    print(response.data);
    print('aaaaaaaaaaaaa');
    return serviceCompanyResponse;
  }

  Future<SubSubCategoryModel> getSubsubCategories(String? id) async {
    String? value = await storage.read(key: "lang");
    print(id);
    Map<String, dynamic> queryParams =
    ({"secret": APIData.secretKey, "id": id, "language": value});

    SubSubCategoryModel? subCategoryModel;
  Response response = await _dio.get(APIData.getSubsubCategory, queryParameters: queryParams);
    subCategoryModel = SubSubCategoryModel.fromJson(response.data);
      print(response.data);
      return subCategoryModel;
      // emit(GetSubSubCatSuccessStates());
  }


  Future<TopBannerResponse> geySliderData() async {
    String? value = await storage.read(key: "lang");

    var queryParameters = {"secret": APIData.secretKey,
      "language":value
    };
    TopBannerResponse? sliderResponse;
    try {
    Response response =await _dio.get(APIData.getSliders, queryParameters: queryParameters);
        log("geySliderData: ${jsonEncode(response.data)}");
      sliderResponse = TopBannerResponse.fromJson(response.data);
      return sliderResponse;
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return sliderResponse!;
  }



  Future<TopCompanyResponse> getTopCompaniesData() async {
    String? value = await storage.read(key: "lang");

    var queryParameters = {"secret": APIData.secretKey,"language": value};
    TopCompanyResponse? topCompanyResponse;
    print('omnia');
    print('dataaomniaaaaa');
    print('dataa');

    try {
      Response response =
      await _dio.get(APIData.getTopCompanies, queryParameters: queryParameters);
      log("getTopCompaniesData: ${jsonEncode(response.data)}");
      topCompanyResponse = TopCompanyResponse.fromJson(response.data);
      return topCompanyResponse;
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return topCompanyResponse!;
  }

  Future<TopProductsResponse> getPopularData() async {
    String? value = await storage.read(key: "lang");

    var queryParameters = {
      "secret": APIData.secretKey,
      "trending": "week",
      "limit": "6",
      "language": value
    };
    TopProductsResponse? topProductsResponse;
    try {
      Response response =
      await _dio.get(APIData.getPopular, queryParameters: queryParameters);
      // log("getPopularData: ${jsonEncode(response.data)}");
      topProductsResponse = TopProductsResponse.fromJson(response.data);
      return topProductsResponse;
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return topProductsResponse!;
  }
}
