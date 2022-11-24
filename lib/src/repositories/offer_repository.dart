import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/services/offers_response.dart';

import '../common/global.dart';

class OffersRepository {
  String tag = "OffersRepository";
  Dio _dio = Dio();

  Future<OffersResponse> getOffersData({required int page}) async {
    String? value = await storage.read(key: "lang");

    Map<String, String> queryParams = ({
      "language": value!,
      "secret": APIData.secretKey,
      "page": page.toString(),
      "paginate": "6"
    });

    late OffersResponse notificationsResponse;
    try {
      Response response =
          await _dio.get(APIData.getOffersData, queryParameters: queryParams);
      notificationsResponse = OffersResponse.fromJson(response.data);

      log("${jsonEncode(response.data)}");
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return notificationsResponse;
  }
}
