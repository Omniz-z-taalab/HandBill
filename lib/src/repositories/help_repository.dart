import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/account/agent_response.dart';
import 'package:hand_bill/src/data/response/help-center-response/help-cnter-response.dart';

import '../common/global.dart';

class HelpRepository {
  String tag = "HelpsRepository";
  Dio _dio = Dio();

  Future<AgentResponse> getAgentData() async {
    String? value = await storage.read(key: "lang");

    Map<String, dynamic> queryParams = ({"secret": APIData.secretKey,"language":value});

    late AgentResponse agentResponse;
    Response response;
    try {
      response =
          await _dio.get(APIData.getAllAgent, queryParameters: queryParams);

      agentResponse = AgentResponse.fromJson(response.data);
      if (agentResponse.status!) {
        return agentResponse;
      } else {
        return agentResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return agentResponse;
  }

  Future<HelpCenterResponse> getHelpData() async {
    String? value = await storage.read(key: "lang");

     Map<String, dynamic> queryParams = ({"language": value});

    late HelpCenterResponse helpCenterResponse;
    Response response;
    try {
      response =
      await _dio.get(APIData.helpCenter,queryParameters: queryParams);

      helpCenterResponse = HelpCenterResponse.fromJson(response.data);
      if (helpCenterResponse.status!) {
        return helpCenterResponse;
      } else {
        return helpCenterResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return helpCenterResponse;
  }
}
