import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/screens/common/services_company/services_company_details_screen.dart';
import 'package:hand_bill/src/ui/screens/details_package/company/company_screen.dart';

class CompanySearchWidget extends StatelessWidget {
  final Company model;
  final bool isHome;

  CompanySearchWidget({required this.model, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (model.leftDataOfCompanies != null &&
              model.images != null &&
              model.logo != null) {
            if (model.natureActivity == "Supplier") {
              Navigator.pushNamed(context, CompanyScreen.routeName,
                  arguments: RouteArgument(param: model.id));
            } else {
              Navigator.pushNamed(
                  context, ServicesCompanyDetailsScreen.routeName,
                  arguments: RouteArgument(param: model.id));
            }
          }
        },
        child: AspectRatio(
            aspectRatio: 4 / 4,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
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
                      height: constraints.maxHeight * 0.60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0)),
                      child: CachedNetworkImage(
                          // imageUrl: placeholder,
                          imageUrl:  model.logo==null?
                          (model.images == null
                              ? placeholder
                              : model.images!.isEmpty
                                  ? placeholder
                                  : isHome
                                      ? model.images![0].url!
                                      : model.images![0].thump!):model.logo!.url!,
                          fit: BoxFit.contain,
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
                        height: constraints.maxHeight * 0.40,
                        bottom: 0,
                        width: constraints.maxWidth,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.name!,
                                      style: TextStyle(
                                        color: textDarkColor,
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.start),
                                  SizedBox(height: 8),
                                  Expanded(
                                      child: Text(model.flag!,
                                          style: TextStyle(
                                            color: textLiteColor,
                                            fontSize: 13,
                                          ),
                                          textAlign: TextAlign.start)),
                                ])))
                  ]));
            })));
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
