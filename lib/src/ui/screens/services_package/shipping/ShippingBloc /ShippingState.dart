import 'package:hand_bill/src/data/response/banner/sub_product.dart';
import 'package:hand_bill/src/data/response/home/serviceCategory_reponse.dart';
import 'package:hand_bill/src/data/response/services/Service_company_response/service_company_response.dart';

import '../../../../../data/model/category/sub.dart';
import '../../../../../data/model/category/sub_sub.dart';
import '../../../../../data/response/banner/banner_service_response.dart';

class ShippingState {}

class ShippingInitState extends ShippingState{}
class ShippingSuccessSubState extends ShippingState{
  final SubCategoryModel? subCategoryModel;
  ShippingSuccessSubState(this.subCategoryModel);
}
class BannerCompanyLoadingState extends ShippingState {}
class BannerCompaniesErrorState extends ShippingState {
  final String errors;
   BannerCompaniesErrorState( this.errors);
}
class BannerCompanySuccessState extends ShippingState {
  List<BannerServiceModel>? banner;
  BannerCompanySuccessState(this.banner){
    print(banner![0].id);
    print('البت امنيه');
  }
}

class ShippingSuccessSubSubState extends ShippingState{
  final SubSubCategoryModel? subCategoryModel;
  ShippingSuccessSubSubState(this.subCategoryModel){
    print(subCategoryModel!.data!.first.name);
  }

}
class ShippingErrorSubState extends ShippingState{
  String error ;
  ShippingErrorSubState(this.error);
}
class ShippingSuccessCategoryState extends ShippingState{}
class ShippingErrorCategoryState extends ShippingState{
  String error ;
  ShippingErrorCategoryState(this.error);
}
class ShippingLoadingSliderState extends ShippingState{}
class ShippingSuccessSliderState extends ShippingState{
  final List<DataPro>? sliders;


  ShippingSuccessSliderState( this.sliders){
    print(sliders![0].id);
  }
}
class ShippingErrorSliderState extends ShippingState{}

class GetSubSubCatSuccessStates extends ShippingState {}
class GebServiceCatSuccessStates extends ShippingState {
  ServiceCompanyResponse category;


  GebServiceCatSuccessStates(this.category);
}
class GetSBannerCatSuccessStates extends ShippingState {}

class GetSubSubCatLoadingState extends ShippingState {}

class GetSubSubCatErrorStates extends ShippingState {
  final String error;
  GetSubSubCatErrorStates(this.error);
}
