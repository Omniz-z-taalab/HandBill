import 'package:hand_bill/src/data/response/banner/sub_product.dart';

abstract class InterState {}

class CubitIntialStates extends InterState {}

class ShopIntresSuccessStates extends InterState {}
class SliderLoadingcategoryState extends InterState {}
class SliderSuccesscategoryState extends InterState {
  final List<DataPro>? items;
  SliderSuccesscategoryState(this.items);
}
class SliderErrorcategoryState extends InterState {
  final String errors;
  SliderErrorcategoryState(this.errors);
}

class ShopIntresLoadingState extends InterState {}

class ShopIntresErrorStates extends InterState {
  final String error;
  ShopIntresErrorStates(this.error);
}

class GetSubCatSuccessStates extends InterState {}

class GetSubCatLoadingState extends InterState {}

class GetSubCatErrorStates extends InterState {
  final String error;
  GetSubCatErrorStates(this.error);
}

