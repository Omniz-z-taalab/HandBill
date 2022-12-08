import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/services/auction_model.dart';
import 'package:hand_bill/src/ui/screens/services_package/auctions/auction_details_screen.dart';

class AuctionWidget extends StatelessWidget {
  final AuctionModel model;

  AuctionWidget({required this.model});

  final double marginVer = 16, marginBetween = 8;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.25;
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, AuctionDetailsScreen.routeName,
              arguments: RouteArgument(param: model));
        },
        child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              CachedNetworkImage(
                  imageUrl: model.images!.isEmpty
                      ? placeholder
                      :  '${model.images![0].url!}',
                  placeholder: (context, url) => Container(
                      height: height,
                      child: Center(
                          heightFactor: 1,
                          widthFactor: 1,
                          child: CircularProgressIndicator(
                              color: mainColorLite, strokeWidth: 2))),
                  errorWidget: (context, url, error) =>
                      new Icon(Icons.error, color: mainColorLite)),
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
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: marginBetween),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Price :".tr(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    Text(model.price.toString(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                  ]),
                              SizedBox(width: 8),
                            ]),
                        SizedBox(height: marginBetween),
                      ]))
            ])));
  }
}
