import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/ui/screens/account_package/wishlist/states.dart';

import '../../../../common/api_data.dart';
import '../../../../common/global.dart';
import '../../../../data/model/services/companies.dart';
import '../../../../data/response/account/account_model.dart';
import '../../../../data/response/services/shipping_response.dart';

class AccountBloc extends Cubit<AccountState> {
  AccountBloc() : super(CubitIntialStates());
  static AccountBloc get(context) => BlocProvider.of(context);

  String tag = "AccountBloc";

  Dio _dio = Dio();
  Future<void> getdata() async {}

  AcountModel? acountModel;
  Future<void> getItems() async {
    String? value = await storage.read(key: "lang");
    Map<String, dynamic> queryParams = ({
      "secret": APIData.secretKey,
       "language" : value
      // "page": page.toString(),
      // "paginate": "6",
      // "nature_activity": "shipping",
      // "category_id": subNature
    });
    _dio.get(APIData.getProfile, queryParameters: queryParams).then((value) {
      acountModel = AcountModel.fromJson(value.data);
      print(value.data);
      print('sssssssssssssssssssss');
      emit(AccountSuccessStates());
    }).catchError((error) {
      print(error.toString());

      emit(AcoountErrorStates(error.toString()));
    });
    // DioHelper.getdata(url: gift, token: token).then((value) {
    //   giftModel = GiftModel.fromJson(value.data);
    //   print(value.data);
    //   emit(GetGiftSuccessStates());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(GetGiftErrorStates());
    // });
  }
}
