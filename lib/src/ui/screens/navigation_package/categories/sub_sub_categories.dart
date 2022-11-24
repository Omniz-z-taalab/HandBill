import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/category/sub_sub.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_sub_category_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/widgets/banner_subsubpro_widget.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/ShippingBloc%20/ShippingEvent.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/ShippingBloc%20/ShippingState.dart';

import '../../../../data/model/local/route_argument.dart';
import '../../../../data/response/banner/sub_product.dart';
import '../../../component/custom/regular_app_bar.dart';
import '../../services_package/shipping/ShippingBloc /cubit.dart';
import '../../services_package/shipping/states.dart';
import '../home/componenet/slider_empty_widget.dart';
import '../home/componenet/slider_widget.dart';

class SubSubCatScreen extends StatefulWidget {
  static const routeName = "/subSUBcat";
  late final RouteArgument? routeArgument;

  SubSubCatScreen({required this.routeArgument});

  @override
  State<SubSubCatScreen> createState() => _SubSubCatScreenState();
}

class _SubSubCatScreenState extends State<SubSubCatScreen> {
  int _sliderPosition = 0;

  List<DataPro> sliders = [];

  SubSubCategoryModel? subCategoryModel;
  ShippingBloc? shippingBloc;

  @override
  void initState() {
    shippingBloc = BlocProvider.of<ShippingBloc>(context);
    super.initState();
    print('ssdsddrrreeee');
    shippingBloc!
      ..add(ShippingSliderEvent(widget.routeArgument!.id.toString()));

    print(widget.routeArgument!.id.toString());
    shippingBloc!
      ..add(ShippingSubSubCategoryEvent(widget.routeArgument!.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShippingBloc, ShippingState>(
      listener: (context, state) {
        if (state is ShippingSuccessSliderState) {
          if (sliders.isEmpty) {
            sliders = state.sliders!;
            print('ssswwwww');
            print(sliders![0].id);
          }
        }

        if (state is ShippingSuccessSubSubState) {
          subCategoryModel = state.subCategoryModel;
          print(subCategoryModel!.data![0].name);

          print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        }
        if (state is ShopIntresErrorStates) {
          print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        }
      },
      builder: (context, state) {
        // var model = ShippingBloc.get(context).subsubCategoryModel;
        return Scaffold(
            backgroundColor: Color(0xfff5f5f5),
            appBar:
                RegularAppBar(label: widget.routeArgument!.param.toString()),
            body: SizedBox(
                height: 700,
                child: SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(
                    height: 200,
                    child: CarouselSlider.builder(
                      itemCount: sliders.length,
                      itemBuilder: (BuildContext context, int index,
                          int pageViewIndex) {
                        if (sliders.isNotEmpty) {
                          return SliderSubWidget(
                              model: sliders![index]);
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
                          autoPlayInterval: Duration(milliseconds: 4000),
                          autoPlayCurve: Curves.easeOutSine,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _sliderPosition = index;
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 600,
                    child: ConditionalBuilder(
                      condition: subCategoryModel != null,
                      builder: (context) => item(subCategoryModel!),
                      fallback: (context) => Container(
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ]))));
      },
    );
  }

  Widget item(SubSubCategoryModel model) => ListView(children: [
        GridView.count(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
            childAspectRatio: 1 / 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            shrinkWrap: true,
            primary: false,
            children: List.generate(model.data!.length, (index) {
              return SubSubCategoryWidget(
                model: model.data![index],
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
