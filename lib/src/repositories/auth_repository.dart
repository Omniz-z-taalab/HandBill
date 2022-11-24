import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/global.dart';
import 'package:hand_bill/src/data/model/profile/profile_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/auth/common_response.dart';
import 'package:hand_bill/src/data/response/auth/countries_response.dart';
import 'package:hand_bill/src/data/response/auth/login_response_.dart';
import 'package:hand_bill/src/data/response/auth/register_response_.dart';
import 'package:hand_bill/src/data/response/auth/send_code_response.dart';

class AuthRepository {
  String tag = "AuthRepository";
  var dio = Dio();
// fetch countries
  Future<CountriesResponse?> fetchCountriesData() async {
    String? value = await storage.read(key: "lang");

    Map<String, String> queryParameters = {"secret": APIData.secretKey,"language":value!};
    Response response;
    CountriesResponse? countriesResponse;
    try {
      response =
          await dio.get(APIData.getCountries, queryParameters: queryParameters);
      countriesResponse = CountriesResponse.fromJson(response.data);
      log("fetchCountriesData: ${jsonEncode(countriesResponse)}");
    } catch (error, stackTrace) {
      print("$tag error $error  stackTrace $stackTrace");
    }
    return countriesResponse;
  }

  Future<LoginResponse?> login({required String mail,required String password}) async {
    String? value = await storage.read(key: "lang");

    FormData formData = new FormData.fromMap({
      "language":value,
      "secret": APIData.secretKey,
      "email": mail,
      "password": password,
      // "device_token": user.deviceToken
    });

    LoginResponse? loginResponse;
    Response? response;
    try {
      response = await dio.post(APIData.login, data: formData);
      loginResponse = LoginResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag ${response!.statusCode}");
      print("$tag error $error , stackTrace: $stackTrace ");
    }
    return loginResponse;
  }

  Future<RegisterResponse?> register({required User user}) async {
    String? value = await storage.read(key: "lang");

    FormData formData = new FormData.fromMap({
      "language": value,
      "secret": APIData.secretKey,
      "email": user.email,
      "password": user.password,
      "confirm_password": user.confirmpassword,
      "name": user.name,
      "device_token": user.deviceToken,
      "country": user.country,
      "phone": user.phone,
      // "name_ar":user.namear,
    });
    RegisterResponse? registerResponse;
    Response? response;
    // try {
    response = await dio.post(
      APIData.register,
      data: formData,
    );
    log("\nregister ${jsonEncode(response.data)}");
    registerResponse = RegisterResponse.fromJson(response.data);
    // } catch (error, stackTrace) {
    //   print("$tag ${response!.statusCode}");
    //   print("$tag error $error , stackTrace: $stackTrace ");
    // }
    return registerResponse;
  }

  Future<CommonResponse?> restPassword({required String code, required String newPassword}) async {
    String? value = await storage.read(key: "lang");
    FormData formData = new FormData.fromMap(
        {"secret": APIData.secretKey, "code": code, "password": newPassword,
        "language":value
        });

    Response response;
    CommonResponse? forgetPasswordResponse;

    try {
      response = await dio.post(APIData.restPassword, data: formData);

      log("${jsonEncode(response.data)}");
      forgetPasswordResponse = CommonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("error $error , stackTrace: $stackTrace ");
    }
    return forgetPasswordResponse;
  }

  Future<CommonResponse?> forgetPassword(String email) async {
    String? value = await storage.read(key: "lang");
    FormData formData =
        new FormData.fromMap({"secret": APIData.secretKey, "email": email,"language":value});

    Response response = await dio.post(APIData.forgetPassword, data: formData);

    CommonResponse forgetPasswordResponse;
    try {
      if (response.statusCode == 200) {
        forgetPasswordResponse = CommonResponse.fromJson(response.data);

        log("${jsonEncode(response.data)}");
        if (forgetPasswordResponse.status!) {
          return forgetPasswordResponse;
        } else {
          return forgetPasswordResponse;
        }
      }
    } catch (error, stackTrace) {
      print("error $error , stackTrace: $stackTrace ");
      return null;
    }
    return null;
  }

  Future<SendCodeResponse?> checkVerificationCode(String code) async {
    String? value = await storage.read(key: "lang");
    FormData formData =
        new FormData.fromMap({"secret": APIData.secretKey, "code": code,"language": value});

    Response response =
        await dio.post(APIData.checkVerificationCode, data: formData);

    try {
      if (response.statusCode == 200) {
        SendCodeResponse codeResponse =
            SendCodeResponse.fromJson(response.data);
        if (codeResponse.status!) {
          return codeResponse;
        } else {
          return codeResponse;
        }
      }
    } catch (error, stackTrace) {
      print("error $error , stackTrace: $stackTrace ");
      return null;
    }
  }


  Future<bool> logging() async {
    currentUser = (await storage.read(key: "currentUser"));
    bool result = true ? currentUser != null : currentUser == null;
    return result;
  }

  void setCurrentUser(jsonString) async {
    try {
      String value = json.encode(jsonString);
      await storage.write(key: "currentUser", value: value);
      log("\nloggedInUser: $value");
    } catch (error, stacktarce) {
      print('error $error , stacktarce $stacktarce');
    }
  }

  Future<User?> getCurrentUser() async {
    User? myUser;
    String? sName;
    sName = await storage.read(key: "currentUser");
    if (sName != null) {
      myUser = User.fromJson(json.decode(sName));
      print("$tag  currentUser = ${json.decode(sName)}");
    } else {
      myUser = null;
    }
    return myUser;
  }

  removeCurrentUser() async {
    await storage.delete(key: "currentUser");
    // await storage.delete(key: "firstTime");
  }
}
