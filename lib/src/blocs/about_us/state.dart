// import 'package:equatable/equatable.dart';
// import 'package:hand_bill/src/data/model/about_us/aboutUsModel.dart';

// abstract class AboutUsState extends Equatable {
//   const AboutUsState();

//   @override
// }

// class AboutUsInitialState extends AboutUsState {}

// class AboutUsLoadingState extends AboutUsState {}

// class AboutUsErrorState extends AboutUsState {
//   final String errors;

//   const AboutUsErrorState({required this.errors});
// }

// //  Categories
// class AboutUsSuccessState extends AboutUsState {
//   final List<AboutUsModel>? items;
//   const AboutUsSuccessState({required this.items});
// }

// // subcategories
// // class SubCategoriesSuccessState extends AboutUsState {
// //   final List<SubCategoryModel>? items;
// //   final Meta? meta;
// //   const SubCategoriesSuccessState({required this.items, this.meta});
// // }

// abstract class AboutStates {}

// class AboutUsCubitIntialStates extends AboutStates {}

// class AboutUsCubitSuccessStates extends AboutStates {}

// class AboutUsCubitLoadingState extends AboutStates {}

// class AboutUsCubitErrorStates extends AboutStates {
//   final String error;
//   AboutUsCubitErrorStates(this.error);
// }
import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/response/aboutUs_response/abotus_response.dart';

abstract class ShopIntresStates extends Equatable {
  const ShopIntresStates();

  @override
  List<Object> get props => [];
}

class ShopCubitIntialStates extends ShopIntresStates {}

class ShopIntresSuccessStates extends ShopIntresStates {
  AboutUsResponse? items;
  ShopIntresSuccessStates(this.items){
    print('yaaaa raaaab');
  }
}

class ShopIntresLoadingState extends ShopIntresStates {}

class ShopIntresErrorStates extends ShopIntresStates {
  final String? error;

  const ShopIntresErrorStates({required this.error});
}
