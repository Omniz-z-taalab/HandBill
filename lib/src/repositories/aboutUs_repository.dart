// import 'dart:convert';
// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:hand_bill/src/common/api_data.dart';

// import '../data/response/home/aboutUs_response.dart';

// class AboutUsRepository {
//   String tag = "AboutUsRepository";
//   Dio _dio = Dio();

//   Future<AboutUsResponse> getItemData() async {
//     var queryParameters = {"secret": APIData.secretKey};
//     late AboutUsResponse aboutUsResponse;

//     try {
//       Response response = await _dio.get(APIData.getAboutItem,
//           queryParameters: queryParameters);
//       aboutUsResponse = AboutUsResponse.fromJson(response.data);
//       log("getitemData: ${jsonEncode(response.data)}");
//       print(response.data.toString());
//       if (aboutUsResponse.status!) {
//         return aboutUsResponse;
//       } else {
//         return aboutUsResponse;
//       }
//     } catch (error, stackTrace) {
//       print("$tag error : $error , stackTrace:  $stackTrace");
//     }
//     return aboutUsResponse;
//   }
// }

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/account/agent_response.dart';

import '../common/global.dart';
import '../data/response/home/aboutUs_response.dart';

class AboutUsRepository {
  String tag = "AboutUsRepository";
  Dio _dio = Dio();

  Future<AboutUsResponse> getItemData() async {
    String? value = await storage.read(key: "lang");
    Map<String, String> queryParams = ({"secret": APIData.secretKey,"language": value!,});

    late AboutUsResponse aboutUsResponse;
    Response response;
    try {
      response =
          await _dio.get(APIData.getAboutItem, queryParameters: queryParams);

      aboutUsResponse = AboutUsResponse.fromJson(response.data);
      if (aboutUsResponse.status!) {
        return aboutUsResponse;
      } else {
        return aboutUsResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return aboutUsResponse;
  }
}
