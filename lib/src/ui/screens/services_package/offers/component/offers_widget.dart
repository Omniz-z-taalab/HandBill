import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/services/offer_model.dart';
import 'package:hand_bill/src/ui/screens/services_package/offers/offers_details_screen.dart';

class OfferWidget extends StatelessWidget {
  final OfferModel model;

  late double _save;

  OfferWidget({required this.model}) {
    _save = (model.oldPrice)! - (model.newPrice)!;
  }

  final double marginVer = 16, marginBetween = 8;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.3;
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, OfferDetailsScreen.routeName,
              arguments: RouteArgument(param: model));
        },
        child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              CachedNetworkImage(
                  imageUrl: model.images!.isEmpty
                      ? placeholder
                      : model.images![0].url!,
                  placeholder: (context, url) => Container(
                      height: height,
                      child: Center(
                          heightFactor: 1,
                          widthFactor: 1,
                          child: CircularProgressIndicator(
                              color: mainColorLite, strokeWidth: 2))),
                  errorWidget: (context, url, error) =>
                      new Icon(Icons.error, color: mainColorLite)),
              Container(
                  color: Color(0xfffafafa), height: 2, width: double.infinity),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(model.title.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            maxLines: 3),
                        SizedBox(height: marginBetween),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Price : ".tr(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: Color(0xffDD2C00),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                          TextSpan(
                                              text: model.oldPrice.toString(),
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                          TextSpan(text: " \$")
                                        ]))
                                  ]),
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: Color(0xffDD2C00),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text: model.company!.name.toString(),
                                            style: TextStyle(
                                                color: Colors.black)),
                                      ]))

                            ]),
                        SizedBox(height: marginBetween),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("With_Deal :".tr(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    Text("${model.newPrice} \$",
                                        style: TextStyle(
                                            color: Color(0xff4CAF50),
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold))
                                  ]),
                              SizedBox(width: 8),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("You_Save : ".tr(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    Text("$_save \$",
                                        style: TextStyle(
                                            color: textDarkColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold))
                                  ])
                            ])
                      ]))
            ])));
  }
}
