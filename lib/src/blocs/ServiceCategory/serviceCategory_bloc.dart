
// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../common/api_data.dart';


// class ShopCubit extends Cubit<ShopIntresStates> {
//   ShopCubit() : super(ShopCubitIntialStates());
//   static ShopCubit get(context) => BlocProvider.of(context);
//   String token = CacheHelper.getData(key: 'token');
//   Dio _dio = Dio();

//   String fimage = "";

//   // GetWalletModel getWalletModel;

//   // Future<CategoriesResponse> getCategoriesData() async {
//   //   var queryParameters = {"secret": APIData.secretKey};
//   //   CategoriesResponse? categoriesResponse;
//   //   Response response;
//   //   try {
//   //     response = await _dio.get(APIData.getCategories,
//   //         queryParameters: queryParameters);
//   //     categoriesResponse = CategoriesResponse.fromJson(response.data);
//   //     log("getCategoriesData: ${jsonEncode(response.data)}");
//   //     if (categoriesResponse.status!) {
//   //       return categoriesResponse;
//   //     } else {
//   //       return categoriesResponse;
//   //     }
//   //   } catch (error, stackTrace) {
//   //     print("$tag error : $error , stackTrace:  $stackTrace");
//   //   }
//   //   return categoriesResponse!;
//   // }
//   void getCategoriesData() {
//         var queryParameters = {"secret": APIData.secretKey};
//             CategoriesResponse? categoriesResponse;

//     Response response;

//      try {
//       response = await _dio.get(APIData.getCategories,
//           queryParameters: queryParameters);
//       categoriesResponse = CategoriesResponse.fromJson(response.data);
//       log("getCategoriesData: ${jsonEncode(response.data)}");
//       if (categoriesResponse.status!) {
//         return categoriesResponse;
//       } else {
//         return categoriesResponse;
//       }
//     } catch (error, stackTrace) {
//       print("$tag error : $error , stackTrace:  $stackTrace");
//     }
//     return categoriesResponse!;
//   }

// }
