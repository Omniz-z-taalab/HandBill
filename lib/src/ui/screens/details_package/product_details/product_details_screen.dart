import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/company/company_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_state.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_bill/src/blocs/products/products_bloc.dart';
import 'package:hand_bill/src/blocs/products/products_event.dart';
import 'package:hand_bill/src/blocs/products/products_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/chats/conversition_model.dart';
import 'package:hand_bill/src/data/model/local/chat_user.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/screens/details_package/product_details/product_details_board.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/response/search/search_product_response.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "/productDetailsScreen";
  final RouteArgument routeArgument;
  ProductDetailsScreen({required this.routeArgument});
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool favorite = false;
  late DataProductSearch _product;
  double? price = 0.0;
  int? favoriteId;
  List<Product> _similarList = [];

  late ProductsBloc _productsBloc;

  late FavoriteBloc _favoriteBloc;
  int? savedId;

  User? _user;
  ConversationModel? _conversation;
  List<ChatUser> _users = [];
  bool showContact = false;
  late CompanyBloc _companyBloc;
  @override
  void initState() {
    _product = widget.routeArgument.param;
    // _product = Product(id: 12);
    _user = BlocProvider.of<GlobalBloc>(context).user;
    savedId = _product.id;
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _companyBloc = BlocProvider.of<CompanyBloc>(context);
    _productsBloc.add(FetchProductDetails(id: _product.id));
    _productsBloc.similarPage = 1;
    // _productsBloc.add(FetchSimilarProductsEvent(subcategoryId: _product.id!, user: _user));
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RegularAppBar(label: "ProductDetails".tr()),
        body: Stack(
          children: [
            RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _similarList.clear();
                    // _productsBloc.add(FetchProductDetails(id: savedId));
                    _productsBloc.similarPage = 1;
                    _productsBloc
                      .add(FetchSimilarProductsEvent(
                          subcategoryId: _product.subSubCategoryId!, user: _user));
                  });
                },
                child: MultiBlocListener(
                    listeners: [
                      BlocListener<ProductsBloc, ProductsState>(
                          listener: (context, state) {
                            if (state is ProductDetailsSuccessState) {
                              setState(() {
                                _product = state.model!;
                                favorite = state.model!.isFavourite!;
                              });
                            }
                            if (state is ProductsErrorState) {
                              Fluttertoast.showToast(msg: state.error!);
                            }

                            if (state is SimilarProductsSuccessState) {
                              setState(() {
                                // _similarList.addAll(state.products!);
                                state.products!.forEach((element) {
                                  if (element.id != _product.id) {
                                    _similarList.add(element);
                                  }
                                });
                              });

                              BlocProvider.of<ProductsBloc>(context).isFetching = false;
                            } else if (state is ProductsErrorState) {
                              // showToast(state.error!, context);
                              BlocProvider.of<ProductsBloc>(context).isFetching = false;
                            }
                          }),
                      BlocListener<FavoriteBloc, FavoriteState>(
                          listener: (context, state) {
                            if (state is AddToFavoriteSuccessState) {
                              setState(() {
                                favorite = !favorite;
                                favoriteId = state.favoriteId;
                              });
                              Fluttertoast.showToast(msg: state.message!);
                            }

                            if (state is RemoveFromFavoriteSuccessState) {
                              setState(() {
                                favorite = !favorite;
                              });
                              Fluttertoast.showToast(msg: state.message!);
                            }
                          })
                    ],
                    child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          _product.company == null
                              ? SliverFillRemaining(
                              child: Center(child: CircularProgressIndicator()))
                              : ProductDetailsBoard(
                              model: _product,
                              similarList: _similarList,
                              user: _user,
                              favotrite: favorite)
                        ]))),
            Positioned(
              bottom: 70.h,
              right: 30.w,
              child:   InkWell(
                onTap: (){
                  setState(() {
                    showContact = !showContact;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(showContact?Icons.close:Icons.chat,size: 30.w,
                    color: Colors.white,),
                ),
              ),),
            if(showContact==true)...[
              Positioned(
                bottom: 500.h,
                right: 30.w,
                child:  Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: IconButton(
                    onPressed: ()async{
                      if (_user == null) {
                        Fluttertoast.showToast(msg: "toast.login".tr());
                      }else{
                        if (_companyBloc.company!.deviceToken != null){
                          //?text=${Uri.parse(description)}
                          await canLaunch("https://wa.me/+2${_companyBloc.company!.firstPhone}")?
                          launch("https://wa.me/+2${_companyBloc.company!.firstPhone}")
                              :print("cannot launch");
                        }
                      }
                    },
                    color: Colors.transparent,
                    icon: Image.asset("assets/icons/whatsappp.png",
                      height: 100.h,width: 100.w,fit: BoxFit.cover,),),
                ),),
              Positioned(
                bottom: 360.h,
                right: 30.w,
                child:  Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: IconButton(
                    onPressed: ()async{
                      if (_user == null) {
                        Fluttertoast.showToast(msg: "toast.login".tr());
                      }else{
                        if (_companyBloc.company!.deviceToken != null){
                          await canLaunch("tel:${_companyBloc.company!.firstPhone}")?
                          launch("tel:${_companyBloc.company!.firstPhone}")
                              :print("cannot launch");
                        }
                      }
                    },
                    color: Colors.white,
                    icon: Icon(Icons.phone,size: 30.w,),),
                ),),
              Positioned(
                bottom: 220.h,
                right: 30.w,
                child: Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: IconButton(
                    onPressed: ()async{
                      if (_user == null) {
                        Fluttertoast.showToast(msg: "login".tr());
                      }else{
                        final Uri params = Uri(
                          scheme: 'mailto',
                          path: '${_companyBloc.company!.email}',
                          query: 'subject=Hand bill request${_product.name.toString().replaceAll("null", "").trim()} &body=description',
                        );
                        final url = params.toString();
                        await canLaunch("$url")?
                        launch("$url"):
                        print("can not open gmail");
                      }
                    },
                    color: Colors.white,
                    icon: Icon(Icons.email,size: 30.w,),),
                ),
              ),
            ],
          ],
        )
    );
  }
}
