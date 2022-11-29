import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/category/sub_category.dart';
import 'package:hand_bill/src/repositories/category_repository.dart';
import '../../data/model/category/sub.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  String tag = "CategoryBloc";

  final CategoryRepository categoryRepository = CategoryRepository();

  CategoryBloc() : super(CategoryInitialState()) {
    on<FetchCategoriesEvent>(_mapFetchCategories);
  }

  int subCatPage = 1;
  bool isFetching = true;

  List<CategoryModel>? categories;

  _mapFetchCategories(
      FetchCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final response = await categoryRepository.getCategoriesData();
    if (response.status!) {
      final items = response.data;
      if (categories == null) {
        items!.first.selected = true;
        categories = items;
      } else {}
      emit(CategoriesSuccessState(items));

    } else {
      emit(CategoryErrorState(errors: response.message.toString()));
    }
  }

// List<SubCategoryModel>? subCategories;
// // static List<SubCategoryModel>? _isolateSubCategories;
// bool isPaginationFinished = false;
//  _mapFetchSubCategories(
//     FetchSubCategoriesEvent event) async {
//   try {
//     if (isFetching == false && isPaginationFinished == true) return;
//     emit(CategoryLoadingState());
//     print("get more data ");
//     final response = await categoryRepository.getSubCategoriesData(
//         categoryId: event.categoryId, page: subCatPage);
//     if (response.status!) {
//       final items = response.data;
//       if (items!.length == 0) {
//         isPaginationFinished = true;
//         isFetching = false;
//       }
//       if (subCategories == null) subCategories = items;
//       emit(SubCategoriesSuccessState(items: items));
//       // emit(SubCategoriesSuccessState(items: items));
//       subCatPage++;
//       isFetching = false;
//     } else {
//       emit(CategoryErrorState(errors: response.message.toString()));
//       isFetching = false;
//     }
//   } catch (e) {
//     emit(CategoryErrorState(errors: "error can not get data now "));
//     isFetching = false;
//     // log(">>>>>>>>>>>>>${e.toString()} ");
//   }
// }

// compute(parseSubCategories,items);
// static parseSubCategories(final responseBody) {
//   _isolateSubCategories = responseBody;
//   print("compute isolate parser sub categories list");
//   print("${categoryBloc.subCategories!.first.name}");
// }
}
