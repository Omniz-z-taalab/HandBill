import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_state.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/products/products_bloc.dart';
import 'package:hand_bill/src/blocs/products/products_event.dart';
import 'package:hand_bill/src/blocs/products/products_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/category/sub_sub_category.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/product/product_hor_widget.dart';
import 'package:hand_bill/src/ui/component/product/product_ver_empty_widget.dart';
import 'package:hand_bill/src/ui/component/product/product_ver_widget.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';

import '../../../../data/model/category/sub_sub.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = "/productsScreen";
  RouteArgument? routeArgument;

  ProductsScreen({this.routeArgument});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product>? _items;

  late ScrollController _scrollController;
  late double offsetVisibleThreshold;
  late SubSubCategoryModelData _subCategory;
  late ProductsBloc _productsBloc;
  bool gridOrList = true;
  User? _user;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _subCategory = widget.routeArgument!.param;
    // _subCategory = SubSubCategoryModel(name: "mobile phone", id: 1);

    _productsBloc.page = 1;
    _productsBloc
      .add(FetchProductsBySubCategoryEvent(
          subcategoryId: _subCategory.id.toString(), user: _user));

    _scrollController = ScrollController()..addListener(_onScroll);
    _user = BlocProvider.of<GlobalBloc>(context).user;

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;

    if (offset + offsetVisibleThreshold >= max && !_productsBloc.isFetching) {
      setState(() {
        _productsBloc.isFetching = true;
      });
      _productsBloc
        .add(FetchProductsBySubCategoryEvent(
            subcategoryId: _subCategory.id.toString(), user: _user));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    offsetVisibleThreshold = size.height;
    return Scaffold(
        key: _scaffoldKey,
        appBar: RegularAppBar(
            label: _subCategory.name!,
            widget: InkWell(
                onTap: () {
                  setState(() {
                    gridOrList = !gridOrList;
                  });
                },
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                        gridOrList == false
                            ? Icons.list_outlined
                            : Icons.grid_view,
                        color: mainColorLite)))),
        body: MultiBlocListener(
            listeners: [
              BlocListener<ProductsBloc, ProductsState>(
                  listener: (context, state) {
                if (state is ProductsErrorState) {
                  _items = [];
                }
                if (state is ProductsSuccessState) {
                  setState(() {
                    if (_items == null) {
                      _items = [];
                    }
                    _items!.addAll(state.products!);
                  });
                }
              }),
              BlocListener<FavoriteBloc, FavoriteState>(
                  listener: (context, state) {
                if (state is AddToFavoriteSuccessState) {
                  _items!.forEach((element) {
                    if (element.id == state.favoriteId) {
                      setState(() {
                        element.isFavourite = '0';
                      });
                    }
                  });
                  displaySnackBar(
                      scaffoldKey: _scaffoldKey,
                      title: state.message.toString());
                }

                if (state is RemoveFromFavoriteSuccessState) {
                  _items!.forEach((element) {
                    if (element.id == state.productId) {
                      setState(() {
                        element.isFavourite = '1';
                      });
                    }
                  });
                  displaySnackBar(
                      scaffoldKey: _scaffoldKey,
                      title: state.message.toString());
                }
              })
            ],
            child: RefreshIndicator(
                onRefresh: () async {
                  // setState(() {
                  //   _items!.clear();
                  //   _items = null;
                  // });

                  _productsBloc.page = 1;
                  _productsBloc
                    .add(FetchProductsBySubCategoryEvent(
                        subcategoryId: _subCategory.id.toString(),
                        user: _user));
                },
                child: CustomScrollView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      _items == null
                          ? SliverToBoxAdapter(child: SizedBox()
                              // StaggeredGridView.countBuilder(
                              //               padding: EdgeInsets.symmetric(
                              //                   horizontal: 16, vertical: 16),
                              //               shrinkWrap: true,
                              //               primary: false,
                              //               crossAxisCount: 4,
                              //               mainAxisSpacing: 16,
                              //               crossAxisSpacing: 16,
                              //               staggeredTileBuilder: (int x) =>
                              //                   StaggeredTile.count(
                              //                       2, x.isEven ? 4 : 3),
                              //               itemBuilder: (BuildContext context,
                              //                   int index) =>
                              //                   ProductVerEmptyWidget(),
                              //               itemCount: 8)
                              )
                          : _items!.length == 0
                              ? CenterWidgetListSliver(
                                  label: 'products will be added soon')
                              : SliverToBoxAdapter(
                                  child: gridOrList == false
                                      ? ListView.separated(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 16),
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: _items == null
                                              ? 2
                                              : _items!.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            if (_items != null) {
                                              return ProductVerWidget(
                                                  model: _items![index],
                                                  user: _user,
                                                  favoriteBloc: _favoriteBloc);
                                            }
                                            return ProductVerEmptyWidget();
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  SizedBox(height: 16))
                                      : SizedBox()
                                  // StaggeredGridView.countBuilder(
                                  //         padding: EdgeInsets.symmetric(
                                  //             horizontal: 16, vertical: 16),
                                  //         shrinkWrap: true,
                                  //         primary: false,
                                  //         crossAxisCount: 4,
                                  //         mainAxisSpacing: 12,
                                  //         crossAxisSpacing: 12,
                                  //         itemCount: _items!.length,
                                  //         staggeredTileBuilder: (int x) =>
                                  //             StaggeredTile.count(
                                  //                 2, x.isEven ? 4 : 3),
                                  //         itemBuilder: (BuildContext context,
                                  //             int index) {
                                  //           return ProductHorWidget(
                                  //               model: _items![index],
                                  //               user: _user,
                                  //               favoriteBloc: _favoriteBloc,
                                  //               canFav: true);
                                  //         })
                                  ),
                      SliverToBoxAdapter(
                          child: _productsBloc.isFetching == true
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2)))
                              : Container())
                    ]))));
  }
}
