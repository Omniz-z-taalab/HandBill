import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/notification_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/general_response.dart';
import 'package:hand_bill/src/data/response/home/notification_response.dart';

class NotificationsRepository {
  String tag = "NotificationsRepository";
  Dio _dio = Dio();
  User? user;

  Future<NotificationResponse> getNotificationsData({required int page}) async {
    Map<String, String> queryParams =
        ({"secret": APIData.secretKey, "page": "$page", "paginate": "12"});

    late NotificationResponse notificationsResponse;
    try {
      Response response = await _dio.get(APIData.getNotificationsData,
          queryParameters: queryParams);
      notificationsResponse = NotificationResponse.fromJson(response.data);
      if (notificationsResponse.status!) {
        return notificationsResponse;
      } else {
        return notificationsResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return notificationsResponse;
  }

  Future<GeneralResponse> markReadNotifiactions(NotificationModel model) async {
    String url =
        "${APIData.markReadNotifications}${model.id}?api_token=${user!.apiToken}";

    late GeneralResponse generalResponse;
    try {
      Response response = await _dio.put(url);
      generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.status!) {
        return generalResponse;
      } else {
        return generalResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return generalResponse;
  }

  Future<GeneralResponse> removeFromNotifiactions(
      NotificationModel model) async {
    Map<String, String> queryParams = ({"api_token": '${user!.apiToken}'});

    late GeneralResponse generalResponse;
    try {
      Response response = await _dio.delete(
          APIData.removeFromNotifications + "${model.id}",
          queryParameters: queryParams);
      generalResponse = GeneralResponse.fromJson(response.data);
      if (generalResponse.status!) {
        return generalResponse;
      } else {
        return generalResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return generalResponse;
  }
}
