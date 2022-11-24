import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_event.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/screens/details_package/product_details/product_details_screen.dart';

class ProductHorWidget extends StatelessWidget {
  final Product model;
  final User? user;
  final bool isHome;
  final bool canFav;
  final FavoriteBloc favoriteBloc;

  ProductHorWidget(
      {required this.model,
      required this.user,
      required this.canFav,
      required this.favoriteBloc,
      this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      Navigator.pushNamed(context, ProductDetailsScreen.routeName,
          arguments: RouteArgument(param: model));
    }, child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          width: constraints.maxHeight,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xfff5f5f5), width: 1.5),
              boxShadow: [
                BoxShadow(
                    color: Color(0xfff5f5f5), blurRadius: 3, spreadRadius: 3)
              ]),
          child: Column(children: [
            Stack(children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: constraints.maxHeight * 0.6,
                width: constraints.maxHeight,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                child: CachedNetworkImage(
                    imageUrl:
                        // imageEx,
                        model.images!.isEmpty
                            ? placeholder
                            : isHome
                                ? model.images![0].url!
                                : model.images![0].thump!,
                    placeholder: (context, url) => Center(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: CircularProgressIndicator(
                            color: mainColorLite, strokeWidth: 1)),
                    errorWidget: (context, url, error) =>
                        new Icon(Icons.error)),
              ),
              canFav == true
                  ? Positioned(
                      top: 8,
                      right: 8,
                      child: InkWell(
                          onTap: () {
                            if (user == null) {
                              Fluttertoast.showToast(
                                  msg: "toast.login".tr());
                            } else {
                              if (model.isFavourite == '0') {
                                favoriteBloc.add(RemoveFromFavoriteEvent(
                                    user: user!, favoriteId: model.id!));
                              } else {
                                favoriteBloc.add(AddToFavoriteEvent(
                                    user: user!, productId: model.id));
                              }
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  border: Border.all(color: Color(0xffeeeeee)),
                                  color: Color(0x99ffffff)),
                              child: Icon(
                                  model.isFavourite == '0'
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  color: mainColorLite,
                                  size: 18))))
                  : SizedBox()
            ]),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(model.name!,
                                  style: Theme.of(context).textTheme.headline1,
                                  textAlign: TextAlign.start,
                                  maxLines: 2)),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                    TextSpan(text: model.price.toString()),
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
                                      imageUrl: model.flag ?? imageFlag,
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
                          ))
                        ])))
          ]));
    }));
  }
}
