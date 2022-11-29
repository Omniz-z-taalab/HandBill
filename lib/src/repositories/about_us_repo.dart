import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../common/api_data.dart';
import '../common/global.dart';
import '../data/response/aboutUs_response/AboutResponse.dart';
import '../data/response/aboutUs_response/abotus_response.dart';

class AboutUsRepo {
  String tag = "AboutUsRepository";
  Dio _dio = Dio();

  Future<AboutResponse?> getItemData() async {
    String? value = await storage.read(key: "lang");
    // Map<String, String> queryParams = ({"secret": APIData.secretKey,"language": value!,});

    AboutResponse? aboutUsResponse;
    Response? response;
    try {
      response = await _dio.get(APIData.getAboutItem);
      // log(response.data);
      log('oooooooooooo');
      log("data: ${jsonEncode(response.data[0])}");

      aboutUsResponse = await AboutResponse.fromJson(response.data[0]);
    } catch (error, stackTrace) {
      aboutUsResponse = null;
      log("$tag error : $error , stackTrace:  $stackTrace");
    }
    return aboutUsResponse;
  }
}
