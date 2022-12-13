import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/services/patented_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/services/patents/all_patents_response.dart';
import 'package:hand_bill/src/data/response/auth/common_response.dart';

import '../common/global.dart';

class PatentsRepository {
  String tag = "PatentsRepository";
  Dio _dio = Dio();

  Future<AllPatentsResponse?> getAllPatentsData({required int page}) async {
    String? value = await storage.read(key: "lang");

    Map<String, String> queryParams =
        ({"secret": APIData.secretKey, "paginate": "$page",
        "language": value!
        });

    late AllPatentsResponse patentsResponse;
    Response response;
    try {
      response =
          await _dio.get(APIData.getAllPatents, queryParameters: queryParams);

      log("${jsonEncode(response.data)}");

      patentsResponse = AllPatentsResponse.fromJson(response.data);
      if (patentsResponse.status!) {
        return patentsResponse;
      } else {
        return patentsResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return patentsResponse;
  }

  Future<AllPatentsResponse?> getMyPatentsData(
      { required User user}) async {
    String? value = await storage.read(key: "lang");

    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";
    Map<String, dynamic> queryParams =
        ({"secret": APIData.secretKey,
          // "paginate": "$page"
          'language':value
        });

    late AllPatentsResponse patentsResponse;
    Response response;
    try {
      response =
          await _dio.get(APIData.getMyPatents);

      log("dataaaaaaaaa${jsonEncode(response.data)}");

      patentsResponse = AllPatentsResponse.fromJson(response.data);
      if (patentsResponse.status!) {
        return patentsResponse;
      } else {
        return patentsResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return patentsResponse;
  }

  Future<CommonResponse?> addPatented(
      {required PatentedModel model,
      required User user,
      required List<Object> images}) async {
    String? value = await storage.read(key: "lang");

    FormData formData;
    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";

    File file1 = images[0] as File;
    String fileName1 = file1.path.split('/').last;

    formData = FormData.fromMap({
      // "secret": APIData.secretKey,
      "title": model.title,
      "language": value,
      "description": model.description,
      "first_image_patent":
          await MultipartFile.fromFile(file1.path, filename: fileName1),
    });
    Response response;

    CommonResponse? commonResponse;

    try {
      response = await _dio.post(APIData.addPatented, data: formData);

      log("${jsonEncode(response.data)}");

      commonResponse = CommonResponse.fromJson(response.data);
      if (commonResponse.status!) {
        return commonResponse;
      } else {
        return commonResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return commonResponse;
  }

  Future<CommonResponse?> removePatented(
      {required PatentedModel model, required User user}) async {
    String? value = await storage.read(key: "lang");

    _dio.options.headers["Authorization"] =
        "Bearer " + user.apiToken.toString();
    _dio.options.headers["Accept"] = "application/json";

    Map<String, dynamic> queryParams =
        ({"secret": APIData.secretKey, "id": model.id.toString(),
        'language': value
        });
    Response response;

    CommonResponse? commonResponse;

    try {
      response = await _dio.delete(APIData.removePatented,
          queryParameters: queryParams);

      log("${jsonEncode(response.data)}");

      commonResponse = CommonResponse.fromJson(response.data);

    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return commonResponse;
  }
}
