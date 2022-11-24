import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/services/auctions_response.dart';

import '../common/global.dart';

class AuctionsRepository {
  String tag = "AuctionsRepository";
  Dio _dio = Dio();

  Future<AuctionsResponse> getAuctionsData({required int page}) async {
    String? value = await storage.read(key: "lang");

    Map<String, String> queryParams = ({
      "language": value!,
      "secret": APIData.secretKey,
      "page": page.toString(),
      "paginate": "6"
    });

    late AuctionsResponse auctionsResponse;

    Response response;
    try {
      response =
          await _dio.get(APIData.getAuctionsData, queryParameters: queryParams);
      auctionsResponse = AuctionsResponse.fromJson(response.data);
      log("${jsonEncode(response.data)}");
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return auctionsResponse;
  }
}
