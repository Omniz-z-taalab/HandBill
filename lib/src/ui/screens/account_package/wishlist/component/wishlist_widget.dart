import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/account_package/favorite_model.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/screens/details_package/product_details/product_details_screen.dart';

class FavoriteWidget extends StatelessWidget {
  final FavoriteModel model;
  final Function? onFavTap;

  FavoriteWidget({required this.model, this.onFavTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      Navigator.pushNamed(context, ProductDetailsScreen.routeName,
          arguments: RouteArgument(param: model.product));
    }, child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xfff5f5f5), width: 1.5)),
          child: Column(children: [
            Stack(children: [
              Container(
                  clipBehavior: Clip.hardEdge,
                  height: constraints.maxHeight * 0.6,
                  width: constraints.maxWidth,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                  child: CachedNetworkImage(
                      imageUrl: model.product!.images!.isEmpty
                          ? placeholder
                          : model.product!.images![0].thump!,
                      placeholder: (context, url) => Center(
                          heightFactor: 1,
                          widthFactor: 1,
                          child: CircularProgressIndicator(
                              color: mainColorLite, strokeWidth: 1)),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error, color: mainColorLite))),
              Positioned(
                  top: 12,
                  right: 12,
                  child: InkWell(
                      onTap: () => onFavTap!(),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Color(0x80ffffff),
                              borderRadius: BorderRadius.circular(90),
                              border: Border.all(color: Colors.red)),
                          child: Icon(Icons.favorite_rounded,
                              size: 16, color: Colors.red))))
            ]),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(model.product!.name!,
                                  style: Theme.of(context).textTheme.headline1,
                                  textAlign: TextAlign.start,
                                  maxLines: 2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                    TextSpan(
                                        text: model.product!.price.toString()),
                                    TextSpan(
                                        text: " \$",
                                        style:
                                            TextStyle(color: Colors.deepOrange))
                                  ])),
                              Container(
                                  height: 24,
                                  width: 24,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4)),
                                  child: CachedNetworkImage(
                                      imageUrl: model.product!.flag ?? imageFlag,
                                      placeholder: (context, url) =>
                                          Transform.scale(
                                              scale: 0.4,
                                              child: CircularProgressIndicator(
                                                  color: mainColorLite,
                                                  strokeWidth: 2)),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error,
                                              color: mainColorLite))),
                            ],
                          )
                        ])))
          ]));
    }));
  }
}
