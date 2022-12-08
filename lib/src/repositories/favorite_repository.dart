import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/account/favorite/add_to_favorite_response.dart';
import 'package:hand_bill/src/data/response/account/favorite/favorite_response.dart';
import 'package:hand_bill/src/data/response/general_response.dart';

import '../common/global.dart';

class FavoriteRepository {
  String tag = "FavoriteRepository";
  Dio _dio = Dio();

  User? _user;

  FavoriteRepository({required BuildContext context}) {
    _user = BlocProvider.of<GlobalBloc>(context).user;
  }

  Future<FavoriteResponse> getFavoriteProducts(
      {required int page, required User user}) async {
    String? value = await storage.read(key: "lang");
    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";
    Map<String, dynamic> queryParams = ({
      "page": page.toString(),
      "paginate": "6",
      "language": value
    });

    late FavoriteResponse favoriteResponse;
    Response response;
    try {
      print('rrrrrr');
      response = await _dio.get(APIData.favouriteProduct,queryParameters: queryParams);
      print('omniaaaaaaaaaaaaaaaa');

      favoriteResponse = FavoriteResponse.fromJson(response.data);
      print('omniaaaaaaaaaaaaaaaa');

      log("${jsonEncode(response.data)}");
      if (favoriteResponse.status!) {
        return favoriteResponse;
      } else {
        return favoriteResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return favoriteResponse;
  }

  Future<AddToFavoriteResponse> addToFavorite(
      {required int productId, required User user}) async {
    String? value = await storage.read(key: "lang");

    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";
    FormData formData = FormData.fromMap(
        { "product_id": "$productId",
        "language": value
        });

    late AddToFavoriteResponse addToFavoriteResponse;
    Response response;
    try {
      response = await _dio.post(APIData.addToFavorite, data: formData);
      addToFavoriteResponse = AddToFavoriteResponse.fromJson(response.data);
      log("${jsonEncode(response.data)}");
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return addToFavoriteResponse;
  }

  Future<GeneralResponse> removeFromFavorite(
      {required int favoriteId, required User user}) async {
    String? value = await storage.read(key: "lang");

    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";

    Map<String, dynamic> queryParams =
        ({"secret": APIData.secretKey, "product_id": "$favoriteId","language":value});
    late GeneralResponse generalResponse;
    Response response;

    try {
      response = await _dio.delete(APIData.removeFromFavorite,
          queryParameters: queryParams);

      log("${jsonEncode(response.data)}");
      generalResponse = GeneralResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return generalResponse;
  }
}
