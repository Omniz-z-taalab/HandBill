import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/category/sub_category.dart';
import 'package:hand_bill/src/data/model/paginate/meta.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryErrorState extends CategoryState {
  final String errors;

  const CategoryErrorState({required this.errors});
}
//  Categories
class CategoriesSuccessState extends CategoryState {
  final List<CategoryModel>? items;

  const CategoriesSuccessState({required this.items});
}

// subcategories
class SubCategoriesSuccessState extends CategoryState {
  final List<SubCategoryModel>? items;
  final Meta? meta;
  const SubCategoriesSuccessState({required this.items,this.meta});
}
