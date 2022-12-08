import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/product/product_details_response.dart';
import 'package:hand_bill/src/data/response/product/products_response.dart';

import '../common/global.dart';
import '../data/response/search/search_product_response.dart';

class ProductsRepository {
  String tag = "ProductsRepository";
  Dio _dio = Dio();
  User? user;
  Future<ProductDetailsResponse> getProductDetail({required int id}) async {
    String? value = await storage.read(key: "lang");
    Map<String, dynamic> queryParams =
    ({
      "language": value
    });
    late ProductDetailsResponse productDetailResponse;
    // try {
      Response response = await _dio.get('${APIData.productDetails}$id',queryParameters: queryParams);
      productDetailResponse = ProductDetailsResponse.fromJson(response.data);
      log("\ngetProductDetail$id: ${jsonEncode(response.data)}");
    // } catch (error, stackTrace) {
    //   print("$tag =>  error : $error , stackTrace : $stackTrace");
    // }
    return productDetailResponse;
  }

  Future<ProductsResponse> getProductsBySubCategory(
      {required String subcategoryId}) async {
    String? value = await storage.read(key: "lang");
    print(subcategoryId);
    print('ffffffff');
    Map<String, dynamic> queryParams = ({
      'sub_sub_category_id': subcategoryId,
      'language': value
    });
    late ProductsResponse productsResponse;
    Response response;
    // try {
      response = await _dio.get(APIData.productDetailss,
          queryParameters: queryParams);
      log("\ngetProductsBySubCategory: ${jsonEncode(response.data)}");
      productsResponse = ProductsResponse.fromJson(response.data);
      if (productsResponse.status!) {
        return productsResponse;
      } else {
        return productsResponse;
      }
    // } catch (error, stackTrace) {
    //   print("$tag error : $error , stackTrace:  $stackTrace");
    // }
    // return productsResponse;
  }

  Future<SearchProductResponse> getSearchProductsub(String id) async {
    String? value = await storage.read(key: "lang");

    Map<String, dynamic> queryParams =
    ({"language": value, "sub_sub_category_id": id});
    SearchProductResponse searchProductResponse;
    Response response = await _dio.get(APIData.productDetailss, queryParameters: queryParams);
    searchProductResponse = SearchProductResponse.fromJson(response.data);
    print(response.data);
    return searchProductResponse;
  }

}
