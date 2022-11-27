// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hand_bill/src/blocs/about_us/event.dart';
// import 'package:hand_bill/src/blocs/about_us/state.dart';
// import 'package:hand_bill/src/data/model/category/category.dart';
// import 'package:hand_bill/src/data/model/category/sub_category.dart';
// import 'package:hand_bill/src/repositories/aboutUs_repository.dart';
// import 'package:hand_bill/src/repositories/category_repository.dart';

// import '../../data/model/about_us/aboutUsModel.dart';

// class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
//   String tag = "AboutUsBloc";

//   AboutUsRepository aboutUsRepository = AboutUsRepository();

//   AboutUsBloc() : super(AboutUsInitialState());
//   // int subCatPage = 1;
//   // bool isFetching = true;

//   @override
//   Stream<AboutUsState> mapEventToState(AboutUsEvent event) async* {
//     if (event is FetchaboutItemEvent) {
//       yield* _mapFetchItem();
//     }
//   }

//   List<AboutUsModel>? aboutItem;
//   Stream<AboutUsState> _mapFetchItem() async* {
//     yield AboutUsLoadingState();

//     final response = await aboutUsRepository.getItemData();
//     if (response.status!) {
//       final items = response.data;
//       print(response.data);
//       // if(categories==null) {
//       //   items!.first.selected = true;
//       //   categories = items;
//       // }
//       yield AboutUsSuccessState(items: items);
//     } else {
//       yield AboutUsErrorState(errors: response.message.toString());
//     }
//   }

//   // List<SubCategoryModel>? subCategories;
//   // // static List<SubCategoryModel>? _isolateSubCategories;
//   // bool isPaginationFinished = false;
//   // Stream<CategoryState> _mapFetchSubCategories(
//   //     FetchSubCategoriesEvent event) async* {
//   //   try{
//   //   if(isFetching == false && isPaginationFinished == true)return;
//   //     yield CategoryLoadingState();
//   //     print("get more data ");
//   //     final response = await categoryRepository.getSubCategoriesData(
//   //         categoryId: event.categoryId, page: subCatPage);
//   //     if (response.status!) {
//   //       final items = response.data;
//   //       if(items!.length==0) {
//   //       isPaginationFinished = true;
//   //       isFetching = false;
//   //     }
//   //     if(subCategories==null) subCategories = items;
//   //       yield SubCategoriesSuccessState(items: items);
//   //       // emit(SubCategoriesSuccessState(items: items));
//   //       subCatPage++;
//   //       isFetching = false;
//   //     } else {
//   //       yield CategoryErrorState(errors: response.message.toString());
//   //       isFetching = false;
//   //     }
//   //   }catch(e){
//   //     yield CategoryErrorState(errors: "error can not get data now ");
//   //     isFetching = false;
//   //     // log(">>>>>>>>>>>>>${e.toString()} ");
//   //   }
//   // }

//   // compute(parseSubCategories,items);
//   // static parseSubCategories(final responseBody) {
//   //   _isolateSubCategories = responseBody;
//   //   print("compute isolate parser sub categories list");
//   //   print("${AboutUsBloc.subCategories!.first.name}");
//   // }

// }

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/about_us/event.dart';
import 'package:hand_bill/src/blocs/about_us/state.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/about_us/aboutUsModel.dart';
import 'package:hand_bill/src/repositories/aboutUs_repository.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, ShopIntresStates>{
  AboutUsBloc() : super(ShopCubitIntialStates());
  AboutUsRepository aboutUsRepository = AboutUsRepository();

  //  AboutUsModel aboutUsModel;
  String tag = "AboutUsBloc";

  Dio _dio = Dio();

  // Future getItemData() async {
  //   var queryParameters = {"secret": APIData.secretKey};
  //   // late AboutUsResponse aboutUsResponse;

  //   try {
  //     Response response = await _dio.get(APIData.getAboutItem,
  //         queryParameters: queryParameters);
  //     aboutUsModel = AboutUsModel.fromJson(response.data);
  //     log("getitemData: ${jsonEncode(response.data)}");
  //     print(aboutUsModel);
  //     // if (aboutUsResponse.status!) {
  //     //   return aboutUsResponse;
  //     // } else {
  //     //   return aboutUsResponse;
  //     // }
  //   } catch (error, stackTrace) {
  //     print("$tag error : $error , stackTrace:  $stackTrace");
  //   }
  //   return aboutUsModel;
  // }

  List<Videos>? aboutCat;
  // ignore: override_on_non_overriding_member
  Stream<ShopIntresStates> mapEventToState(AboutUsEvent event) async* {
    if (event is FetchaboutItemEvent) {
      yield* _mapFetchabout(event);
    }
  }

  Stream<ShopIntresStates> _mapFetchabout(FetchaboutItemEvent event) async* {
    yield ShopIntresLoadingState();
    final response = await aboutUsRepository.getItemData();
    print('rrrr');
      final items = response!.videos;
      if (aboutCat == null) {
        print('wwwvvvvv');

        // items!.first.. = true;
        aboutCat = items;
        print(aboutCat);
        print('wwwvvvvv');
      }
      yield ShopIntresSuccessStates();
      // yield ShopIntresErrorStates(error: response);

  }
}


 

    // DioHelper.getdata(url: getwallet, token: token).then((value) {
    //   getWalletModel = GetWalletModel.fromJson(value.data);
    //   // print(value.data);
    //   emit(WalletSuccessStates());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(WalletErrorStates(error));
    // });
  

