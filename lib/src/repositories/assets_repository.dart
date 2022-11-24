import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/services/assets_response.dart';

import '../common/global.dart';

class AssetsRepository {
  String tag = "AssetsRepository";
  Dio _dio = Dio();

  Future<AssetsResponse> getAssetsData() async {
    String? value = await storage.read(key: "lang");
    Map<String, String> queryParams = ({
        "language": value!,});
    late AssetsResponse assetsResponse;
    try {
      Response response =
          await _dio.get(APIData.getAssetsData,queryParameters: queryParams);
      assetsResponse = AssetsResponse.fromJson(response.data);
      // log("${jsonEncode(response.data)}");

    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return assetsResponse;
  }
}
