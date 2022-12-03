// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hand_bill/src/blocs/search/search_event.dart';
// import 'package:hand_bill/src/data/model/local/route_argument.dart';
// import 'package:hand_bill/src/data/model/product.dart';
// import 'package:hand_bill/src/data/response/search/search_product_response.dart';
//
// import '../../../../../blocs/favorite/favorite_bloc.dart';
// import '../../../../../blocs/favorite/favorite_event.dart';
// import '../../../../../blocs/favorite/favorite_state.dart';
// import '../../../../../blocs/global_bloc/global_bloc.dart';
// import '../../../../../blocs/home/home_bloc.dart';
// import '../../../../../blocs/search/search_bloc.dart';
// import '../../../../../blocs/search/search_state.dart';
// import '../../../../../common/constns.dart';
// import '../../../../../data/model/user.dart';
//
// class ProductDetails extends StatefulWidget {
//   static const routeName = "/ProductDetalis";
//   final RouteArgument routeArgument;
//
//   const ProductDetails({required this.routeArgument});
//
//   @override
//   State<ProductDetails> createState() => _ProductDetailsState();
// }
//
// class _ProductDetailsState extends State<ProductDetails> {
//   User? user;
//   HomeBloc? _homeBloc;
//   late SearchD product;
//   late FavoriteBloc favoriteBloc;
//
//   late SearchBloc _searchBloc;
//
//   @override
//   void didChangeDependencies() {
//     _homeBloc = BlocProvider.of<HomeBloc>(context);
//     super.didChangeDependencies();
//   }
//
//   @override
//   void initState() {
//     _searchBloc = BlocProvider.of<SearchBloc>(context);
//     favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
//     user = BlocProvider.of<GlobalBloc>(context).user;
//     product = widget.routeArgument.param;
//     print(product.name);
//     print(product.id);
//     print('sokaaaaaaa');
//     super.initState();
//   }
//
//   getUser() {
//     user = BlocProvider.of<GlobalBloc>(context).user;
//     if (user != null) {
//       print(user!.name!);
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey.shade100,
//         body: BlocConsumer<FavoriteBloc, FavoriteState>(
//             listener: (context, state) {
//           if (state is AddToFavoriteSuccessState) {
//             _homeBloc!.popularList.forEach((element) {
//               if (element.id == state.favoriteId) {
//                 setState(() {
//                   element.isFavourite = true;
//                 });
//               }
//             });
//             Fluttertoast.showToast(
//                 msg: state.message ?? '',
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.CENTER,
//                 timeInSecForIosWeb: 1,
//                 backgroundColor: Colors.green,
//                 textColor: Colors.white,
//                 fontSize: 16.0);
//           }
//
//           if (state is RemoveFromFavoriteSuccessState) {
//             _homeBloc!.popularList.forEach((element) {
//               if (element.id == state.productId) {
//                 setState(() {
//                   element.isFavourite = false;
//                 });
//               }
//             });
//             Fluttertoast.showToast(
//                 msg: state.message ?? '',
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.CENTER,
//                 timeInSecForIosWeb: 1,
//                 backgroundColor: Colors.green,
//                 textColor: Colors.white,
//                 fontSize: 16.0);
//           }
//         }, builder: ( (BuildContext context, state) {
//           return SingleChildScrollView(
//               child: SafeArea(
//                 child: Column(children: [
//                   Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Container(
//                           height: 500,
//                           width: 370,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Colors.black26,
//                                     spreadRadius: 3,
//                                     blurRadius: 6)
//                               ]),
//                           child: Column(children: [
//                             Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Stack(children: [
//                                 Container(
//                                     height: 300,
//                                     width: 300,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(color: Colors.grey)),
//                                     child: CachedNetworkImage(
//                                         width: 370,
//                                         // height: 200,
//                                         imageUrl: product!.images!.isEmpty
//                                             ? placeholder
//                                             : product!.images![0].thump!,
//                                         placeholder: (context, url) =>
//                                             Center(
//                                                 heightFactor: 1,
//                                                 widthFactor: 1,
//                                                 child: CircularProgressIndicator(
//                                                     color: mainColorLite,
//                                                     strokeWidth: 1)),
//                                         errorWidget: (context, url, error) =>
//                                         new Icon(Icons.error,
//                                             color: mainColorLite))),
//                                 Positioned(
//                                     top: 12,
//                                     right: 12,
//                                     child: InkWell(onTap: () {
//                                       if (product.isFavourite == false) {
//                                         favoriteBloc.add(AddToFavoriteEvent(
//                                             productId: product!.id!,
//                                             user: user!));
//                                         setState(() {
//                                           product.isFavourite = true;
//                                         });
//                                         product.isFavourite = true;
//                                       } else {
//                                         favoriteBloc.add(
//                                             RemoveFromFavoriteEvent(
//                                                 user: user!,
//                                                 favoriteId: product!.id!));
//                                         SingleChildScrollView(
//                                           child: SafeArea(
//                                               child: Column(
//                                                 children: [
//                                                   Padding(
//                                                       padding: const EdgeInsets
//                                                           .all(15.0),
//                                                       child: Container(
//                                                           clipBehavior: Clip
//                                                               .hardEdge,
//                                                           height: 200,
//                                                           width: 300,
//                                                           decoration:
//                                                           BoxDecoration(
//                                                               borderRadius: BorderRadius
//                                                                   .circular(
//                                                                   8.0)),
//                                                           child: CachedNetworkImage(
//                                                               imageUrl: product!
//                                                                   .images!
//                                                                   .isEmpty
//                                                                   ? placeholder
//                                                                   : product!
//                                                                   .images![0]
//                                                                   .thump!,
//                                                               placeholder: (
//                                                                   context,
//                                                                   url) =>
//                                                                   Center(
//                                                                       heightFactor: 1,
//                                                                       widthFactor: 1,
//                                                                       child: CircularProgressIndicator(
//                                                                           color: mainColorLite,
//                                                                           strokeWidth: 1)),
//                                                               errorWidget: (
//                                                                   context, url,
//                                                                   error) =>
//                                                               new Icon(
//                                                                   Icons.error,
//                                                                   color: mainColorLite)))),
//                                                   Positioned(
//                                                       top: 12,
//                                                       right: 12,
//                                                       child: InkWell(
//                                                           child: Container(
//                                                               padding: EdgeInsets
//                                                                   .all(8),
//                                                               decoration: BoxDecoration(
//                                                                   color: Color(
//                                                                       0x80ffffff),
//                                                                   borderRadius: BorderRadius
//                                                                       .circular(
//                                                                       90),
//                                                                   border: Border
//                                                                       .all(
//                                                                       color: Colors
//                                                                           .red)),
//                                                               child: Icon(Icons
//                                                                   .favorite_rounded,
//                                                                   size: 16,
//                                                                   color: Colors
//                                                                       .red))))
//                                                   ,
//                                                   Expanded(
//                                                       child: Padding(
//                                                           padding: EdgeInsets
//                                                               .symmetric(
//                                                               horizontal: 12,
//                                                               vertical: 12),
//                                                           child: Column(
//                                                               mainAxisAlignment: MainAxisAlignment
//                                                                   .spaceAround,
//                                                               crossAxisAlignment: CrossAxisAlignment
//                                                                   .start,
//                                                               children: [
//                                                                 Expanded(
//                                                                     child: Text(
//                                                                         product
//                                                                             .name!,
//                                                                         style: Theme
//                                                                             .of(
//                                                                             context)
//                                                                             .textTheme
//                                                                             .headline1,
//                                                                         textAlign: TextAlign
//                                                                             .start,
//                                                                         maxLines: 2)),
//                                                                 Row(
//                                                                   mainAxisAlignment: MainAxisAlignment
//                                                                       .spaceBetween,
//                                                                   children: [
//                                                                     RichText(
//                                                                         text: TextSpan(
//                                                                             style: TextStyle(
//                                                                                 fontSize: 13,
//                                                                                 color: Colors
//                                                                                     .black,
//                                                                                 fontWeight: FontWeight
//                                                                                     .bold),
//                                                                             children: [
//                                                                               TextSpan(
//                                                                                   text: product!
//                                                                                       .price
//                                                                                       .toString()),
//                                                                               TextSpan(
//                                                                                   text: " \$",
//                                                                                   style:
//                                                                                   TextStyle(
//                                                                                       color: Colors
//                                                                                           .deepOrange))
//                                                                             ])),
//                                                                     Container(
//                                                                         height: 24,
//                                                                         width: 24,
//                                                                         clipBehavior: Clip
//                                                                             .hardEdge,
//                                                                         decoration: BoxDecoration(
//                                                                             borderRadius: BorderRadius
//                                                                                 .circular(
//                                                                                 4)),
//                                                                         child: CachedNetworkImage(
//                                                                             imageUrl: product!
//                                                                                 .flag ??
//                                                                                 imageFlag,
//                                                                             placeholder: (
//                                                                                 context,
//                                                                                 url) =>
//                                                                                 Transform
//                                                                                     .scale(
//                                                                                     scale: 0.4,
//                                                                                     child: CircularProgressIndicator(
//                                                                                         color: mainColorLite,
//                                                                                         strokeWidth: 2)),
//                                                                             errorWidget: (
//                                                                                 context,
//                                                                                 url,
//                                                                                 error) =>
//                                                                             new Icon(
//                                                                                 Icons
//                                                                                     .error,
//                                                                                 color: mainColorLite))),
//                                                                   ],
//                                                                 )
//                                                               ]))),
//                                                   Padding(
//                                                     padding:
//                                                     const EdgeInsets.only(
//                                                         left: 15.0,
//                                                         top: 10),
//                                                     child: Row(children: [
//                                                       Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Text(
//                                                               'Price :',
//                                                               style:
//                                                               TextStyle(
//                                                                 color: Colors
//                                                                     .grey
//                                                                     .shade700,
//                                                                 fontSize: 15,
//                                                               ))),
//                                                       Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .only(
//                                                             left: 15.0),
//                                                         child: Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Text(
//                                                               '${product
//                                                                   .price}\$ ',
//                                                               style:
//                                                               TextStyle(
//                                                                 color: Colors
//                                                                     .grey
//                                                                     .shade800,
//                                                                 fontSize: 15,
//                                                               )),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 50,
//                                                       ),
//                                                     ]),
//                                                   ),
//                                                   Padding(
//                                                       padding:
//                                                       EdgeInsets.only(
//                                                           top: 20,
//                                                           left: 10),
//                                                       child: Text(
//                                                           product!
//                                                               .company!.name!,
//                                                           style: TextStyle(
//                                                             color: Colors.grey
//                                                                 .shade800,
//                                                             fontSize: 15,
//                                                           )))
//                                                 ],
//                                               )),
//                                         );
//                                       }
//                                     })),
//                               ]),
//                             ),
//                           ])))
//
//                 ]),
//               )
//           );
//         })
//         ));
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/search/search_event.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/response/search/search_product_response.dart';

import '../../../../../blocs/favorite/favorite_bloc.dart';
import '../../../../../blocs/favorite/favorite_event.dart';
import '../../../../../blocs/favorite/favorite_state.dart';
import '../../../../../blocs/global_bloc/global_bloc.dart';
import '../../../../../blocs/home/home_bloc.dart';
import '../../../../../blocs/search/search_bloc.dart';
import '../../../../../blocs/search/search_state.dart';
import '../../../../../common/constns.dart';
import '../../../../../data/model/user.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = "/ProductDetalis";
  final RouteArgument routeArgument;

  const ProductDetails({required this.routeArgument});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  User? user;
  HomeBloc? _homeBloc;
  late DataProductSearch product;
  late FavoriteBloc favoriteBloc;
  String? isfavourite;

  late SearchBloc _searchBloc;

  @override
  void didChangeDependencies() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    user = BlocProvider.of<GlobalBloc>(context).user;
    product = widget.routeArgument.param;
    print(product.name);
    print(product.id);
    print('sokaaaaaaa');
    super.initState();
  }

  getUser() {
    user = BlocProvider.of<GlobalBloc>(context).user;
    if (user != null) {
      print(user!.name!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){
          Navigator.pop(context);

        },),
        title: Text('Back',style: TextStyle(
          color: Colors.black,
          fontSize: 25
        ),),
      ),
      backgroundColor: Colors.grey.shade100,
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is AddToFavoriteSuccessState) {
            _homeBloc!.popularList.forEach((element) {
              if (element.id == state.favoriteId) {
                setState(() {
                  element.isFavourite = true;
                });
              }
              Fluttertoast.showToast(msg: state.message!);

            });
            Fluttertoast.showToast(
                msg: state.message ?? '',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is RemoveFromFavoriteSuccessState) {
            _homeBloc!.popularList.forEach((element) {
              if (element.id == state.productId) {
                setState(() {
                  element.isFavourite = false;
                });
              }
            });
            Fluttertoast.showToast(
                msg: state.message ?? '',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        height: 500,
                        width: 370,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 3,
                                  blurRadius: 6)
                            ]),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Stack(children: [
                                  Container(
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey)),
                                      child: CachedNetworkImage(
                                          width: 370,
                                          // height: 200,
                                          imageUrl: product!.images!.isEmpty
                                              ? placeholder
                                              : '${product.images![0].thump!}',
                                          placeholder: (context, url) => Center(
                                              heightFactor: 1,
                                              widthFactor: 1,
                                              child: CircularProgressIndicator(
                                                  color: mainColorLite,
                                                  strokeWidth: 1)),
                                          errorWidget: (context, url, error) =>
                                          new Icon(Icons.error,
                                              color: mainColorLite))),
                                  Positioned(
                                      top: 12,
                                      right: 12,
                                      child: InkWell(
                                          onTap: () {
                                            if (product.isFavourite == false) {
                                              favoriteBloc.add(AddToFavoriteEvent(
                                                  productId: product!.id,
                                                  user: user!));
                                              product.isFavourite = true;
                                            } else if(user == null){
                                              Fluttertoast.showToast(msg: 'Log in first',backgroundColor: Colors.green,fontSize: 20,);
                                              }else{
                                              favoriteBloc.add(
                                                  RemoveFromFavoriteEvent(
                                                      user: user!,
                                                      favoriteId: product.id));

                                              product.isFavourite = false;
                                            }
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Color(0x80ffffff),
                                                  borderRadius:
                                                  BorderRadius.circular(90),
                                                  border: Border.all(
                                                      color: Color(0x14000000))),
                                              child: Icon(product.isFavourite == false
                                                  ?Icons.favorite_border
                                                  : Icons.favorite_rounded,
                                                  size: 16,
                                                  color: Colors.red)))),
                                ])),
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Name :',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 15,
                                          )),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(product.name!,
                                          style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 15,
                                          )),
                                    )),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 10),
                              child: Row(children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Price :',
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 15,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('${product.price}\$ ',
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 15,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                              ]),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20,left: 10),
                                child: Text(product!.company!.name!,style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 15,)
                                ))
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}