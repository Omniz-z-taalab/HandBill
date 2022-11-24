import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/screens/common/services_company/services_company_details_screen.dart';
import 'package:hand_bill/src/ui/screens/details_package/company/company_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyHorWidget extends StatelessWidget {
  final Company model;
  final bool isHome;

  CompanyHorWidget({required this.model, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (model.natureActivity == "Supplier") {
            Navigator.pushNamed(context, CompanyScreen.routeName,
                arguments: RouteArgument(param: model.id));
          } else {
            Navigator.pushNamed(context, ServicesCompanyDetailsScreen.routeName,
                arguments: RouteArgument(param: model.id));
          }
        },
        child:Container(
            height: 550.h,
            // width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Color(0xfff5f5f5), width: 1.5),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xfff5f5f5),
                      blurRadius: 3,
                      spreadRadius: 3)
                ]),
            child: Stack(fit: StackFit.loose, children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: 350.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0)),
                child: CachedNetworkImage(
                  // imageUrl: placeholder,
                    imageUrl: model.images == null
                        ? placeholder
                        : model.images!.isEmpty
                        ? placeholder
                        : isHome
                        ? model.images![0].url!
                        : model.images![0].thump!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: CircularProgressIndicator(
                            color: mainColorLite, strokeWidth: 1)),
                    errorWidget: (context, url, error) =>
                    new Icon(Icons.error, color: mainColorLite)),
              ),
              Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(900)),
                      child: CachedNetworkImage(
                          imageUrl: model.flag!,
                          fit: BoxFit.fill,
                          width: 24,
                          height: 24))),
              Positioned(
                  height: 150.h,
                  bottom: 10,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 900.w,
                              child: Text(model.name!,
                                  style: TextStyle(
                                    color: textDarkColor,
                                    fontSize: 15,overflow: TextOverflow.ellipsis
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.start),
                            ),
                            Expanded(
                                child: Text(model.flag!,
                                    style: TextStyle(
                                      color: textLiteColor,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.start)),
                          ])))
            ])));
  }

  Widget marketOption({required String title, required BuildContext context}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            color: widgetColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Theme.of(context).cardColor, width: 0.2)),
        child: Center(
            child: Text(title, style: Theme.of(context).textTheme.bodyText1)));
  }
}
