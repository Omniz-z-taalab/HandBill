import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_bloc.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_event.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/category/sub.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/services/companies.dart';
import 'package:hand_bill/src/data/response/services/Service_company_response/service_company_response.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/common/services_company_widget/customs_widget.dart';
import 'package:hand_bill/src/ui/screens/services_package/customs/customs_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/ShippingBloc%20/cubit.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/shippinhWidget.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/states.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/widget/service_banner_widget.dart';

import '../../../../../common/api_data.dart';
import '../../../../../data/model/local/route_argument.dart';
import '../../../../../data/model/serviceCategories_model.dart';
import '../../../../../data/response/banner/banner_service_response.dart';
import '../../categories/sub_sub_categories.dart';
import '../../home/componenet/slider_empty_widget.dart';
import '../../../services_package/shipping/ShippingBloc /ShippingEvent.dart';
import '../../../services_package/shipping/ShippingBloc /ShippingState.dart';


class ShippingScreen extends StatefulWidget {
  static const routeName = "/ShippingScreen";
  late final RouteArgument? routeArgument;

  ShippingScreen({required this.routeArgument});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  List<BannerServiceModel>? banner;
  ServiceCompanyResponse? companyModel;
  ServiceModel? model;
  ShippingBloc? shippingBloc;
  int _sliderPosition = 0;

  // BlocProvider(
  //       create: ((context) => ShippingBloc()
  //         ..getCategory(subNature: widget.routeArgument!.id.toString())),
  //
  //       child:
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('[[]]');
    // print(widget!.routeArgument!);
     model = widget.routeArgument!.param;
    shippingBloc = BlocProvider.of<ShippingBloc>(context);
    shippingBloc!.add(ShippingSliderServiceEvent());
    shippingBloc!.add(ShippingCategoryServiceEvent(model!.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShippingBloc, ShippingState>(
      listener: (context, state) {
        if (state is BannerCompanySuccessState) {
          banner = state.banner!;
        }
        if (state is GebServiceCatSuccessStates) {
          companyModel = state.category!;
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Color(0xfff5f5f5),
            appBar:
                RegularAppBar(label: model!.name),
            body: SizedBox(
              height: 700,
              child: SingleChildScrollView(
                child: Column(children: [
                  Column(
                    children: [
                      banner == null
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                          : SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: CarouselSlider.builder(
                                itemCount: banner!.length,
                                itemBuilder: (BuildContext context, int index,
                                    int pageViewIndex) {
                                  if (banner!.isNotEmpty) {
                                    return BannerWidget(model: banner![index]);
                                  }
                                  return SliderEmptyWidget();
                                },
                                options: CarouselOptions(
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    // enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                    autoPlayInterval:
                                        Duration(milliseconds: 4000),
                                    autoPlayCurve: Curves.easeOutSine,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _sliderPosition = index;
                                      });
                                    }),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 400,
                      child: companyModel == null
                          ? Center()
                          : companyModel!.data!.length == 0
                              ? Container(
                                  color: Colors.white,
                                  child: Center(

                                      child: Text(
                                        'No Companies yet',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 25),
                                    ),
                                  ))
                              : item(companyModel!)),
                ]),
              ),
            ));
      },
    );
  }

  // Widget item(SubCategoryModel model) =>
  //     InkWell(
  //       onTap: (){
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //             child: ListView.separated(
  //                 physics: BouncingScrollPhysics(),
  //                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
  //                 primary: false,
  //                 shrinkWrap: true,
  //                 itemCount: model.data!.length,
  //                 scrollDirection: Axis.vertical,
  //                 itemBuilder: (context, index) =>
  //                     ShapWidget(
  //                       model: model!.data![index],
  //                     ),
  //                 separatorBuilder: (BuildContext context, int index) =>
  //                     Container(height: 10, color: Color(0xffeeeeee))
  //               //  ShapWidget(
  //               //   model: model.data.firs[index],
  //               // );
  //
  //               // separatorBuilder: (BuildContext context, int index) =>
  //               //     Container(height: 10, color: Color(0xffeeeeee))
  //             )),
  //       ),
  //     );

  Widget item(ServiceCompanyResponse model) => ListView(children: [
        GridView.count(
            // padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
            childAspectRatio: 1 / 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            shrinkWrap: true,
            primary: false,
            children: List.generate(model.data!.length, (index) {
              return InkWell(
                onTap: () {
                  print('fdfdfdfdfdfdf');
                  print('${model.data![index].id}');
                  Navigator.pushNamed(context, SubSubCatScreen.routeName,
                      arguments: RouteArgument(
                        id: model.data![index].id.toString(),
                        param: model.data![index].name.toString(),
                      ));
                },
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              model.data![index].name == null
                                  ? Container(
                                      child: Image.asset(
                                        "assets/images/Hbill.jpeg",
                                        height: 40,
                                        // width: 20,
                                      ),
                                    )
                                  : Image.network(
                                      '${APIData.domainLink}${model.data![index].flag!}',
                                      height: 30,
                                    ),
                              Text(model.data![index].name.toString(),
                                  style: model.data![index].id.toString() ==
                                          model.data!.first.id.toString()
                                      ? TextStyle(
                                          color: mainColorLite,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)
                                      : TextStyle(
                                          color: textDarkColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis)
                            ]))),
              );
              // InkWell(
              //   child: Card(
              //       elevation: 5,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8)),
              //       child: Padding(
              //           padding:
              //               EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              //           child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceAround,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(model.data![index].name!,

              //                     style: model.selected == true
              //                     ? TextStyle(
              //                         color: mainColorLite,
              //                         fontWeight: FontWeight.w500,
              //                         fontSize: 12)
              //                     :
              //                      TextStyle(
              //                         color: textDarkColor,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     maxLines: 3,
              //                     textAlign: TextAlign.center,
              //                     overflow: TextOverflow.ellipsis)
              //               ]))),
              // );
            })),
        SizedBox(height: 80),
      ]);
}
