import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/services/handmade_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/services/handmade/add_handmade_response.dart';
import 'package:hand_bill/src/data/response/services/handmade/all_handmade_response.dart';
import 'package:hand_bill/src/data/response/auth/common_response.dart';

import '../common/global.dart';

class HandmadeRepository {
  String tag = "HandmadeRepository";
  Dio _dio = Dio();

  Future<AllHandmadeResponse?> getAllHandmadeData({required int page}) async {
    String? value = await storage.read(key: "lang") ?? 'en';
    Map<String, dynamic> queryParams = ({
      "language": value,
      "secret": APIData.secretKey,
      "page": page.toString(),
      "paginate": "6"
    });
    print(page.toString());
    late AllHandmadeResponse handmadeResponse;
    Response response;
    try {
      response =
          await _dio.get(APIData.getAllHandmade, queryParameters: queryParams);

      log("${jsonEncode(response.data)}");

      handmadeResponse = AllHandmadeResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return handmadeResponse;
  }

  Future<AllHandmadeResponse?> getMyHandmadeData({required User user}) async {
    String? value = await storage.read(key: "lang");

    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";
    Map<String, dynamic> queryParam = ({"language": value});
    late AllHandmadeResponse handmadeResponse;
    Response response;
    try {
      response = await _dio.get(
        APIData.myHandmade,
      );

      log("${jsonEncode(response.data)}");

      handmadeResponse = AllHandmadeResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return handmadeResponse;
  }

  Future<CommonResponse?> addHandmade(
      {required HandmadeModel model,
      required User user,
      required List<dynamic> images}) async {
    String? value = await storage.read(key: "lang");
    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";
    FormData formData;
    File file1;
    File file2;
    File file3;
    Map<String, dynamic> _map = {
      "language": value,
      // "secret": APIData.secretKey,
      "title": model.title,
      "price": model.price,
      "description": model.description,
      // "first_image_hand_made": model.images![0].url!
    };
    if (images.length == 1) {
      file1 = images[0] as File;
      _map["first_image_hand_made"] = await MultipartFile.fromFile(file1.path,
          filename: file1.path.split('/').last);
    } else if (images.length == 2) {
      file1 = images[0] as File;
      file2 = images[1] as File;
      _map["first_image_hand_made"] = await MultipartFile.fromFile(file1.path,
          filename: file1.path.split('/').last);
      _map["second_image_hand_made"] = await MultipartFile.fromFile(file2.path,
          filename: file2.path.split('/').last);
    } else if (images.length == 3) {
      file1 = images as File;
      file2 = images as File;
      file3 = images as File;
      _map["first_image_hand_made"] = await MultipartFile.fromFile(file1.path,
          filename: file1.path.split('/').last);
      _map["second_image_hand_made"] = await MultipartFile.fromFile(file2.path,
          filename: file2.path.split('/').last);
      _map["third_image_hand_made"] = await MultipartFile.fromFile(file3.path,
          filename: file3.path.split('/').last);
    }

    formData = FormData.fromMap(_map);
    Response response;

    CommonResponse? commonResponse;

    try {
      response = await _dio.post(APIData.addHandmade, data: formData);
      print(response.data);
      log("${jsonEncode(response.data)}");

      commonResponse = CommonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return commonResponse;
  }

  Future<CommonResponse?> removeHandmade(
      {required HandmadeModel model, required User user}) async {
    String? value = await storage.read(key: "lang");
    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";

    Map<String, dynamic> queryParams = ({
      "secret": APIData.secretKey,
      "id": model.id.toString(),
      "language": value
    });
    Response response;

    CommonResponse? commonResponse;

    try {
      response = await _dio.delete(APIData.removeHandmade,
          queryParameters: queryParams);

      log("${jsonEncode(response.data)}");

      commonResponse = CommonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return commonResponse;
  }
}
