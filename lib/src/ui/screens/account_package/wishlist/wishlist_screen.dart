import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_event.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_state.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/data/model/account_package/favorite_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/product/product_ver_empty_widget.dart';
import 'package:hand_bill/src/ui/screens/account_package/wishlist/component/wishlist_widget.dart';

class WishListScreen extends StatefulWidget {
  static const routeName = "/WishListScreen";

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<FavoriteModel>? _items;

  late ScrollController _scrollController;
  static const offsetVisibleThreshold = 50.0;
  late FavoriteBloc _favoriteBloc;
  User? _user;

  @override
  void initState() {
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _user = BlocProvider.of<GlobalBloc>(context).user;
    if (_user != null) {
      _favoriteBloc.page = 1;
      _favoriteBloc..add(FetchFavoriteEvent(user: _user!));
    }
    _scrollController = ScrollController()..addListener(_onScroll);
    print(';;;;;;;;;;;;;');
    super.initState();
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;

    if (offset + offsetVisibleThreshold >= max &&
        !BlocProvider.of<FavoriteBloc>(context).isFetching) {
      _favoriteBloc
        ..isFetching = true
        ..add(FetchFavoriteEvent(user: _user!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RegularAppBar(label: "WishList".tr()),
        body: RefreshIndicator(
            onRefresh: () async {
              if (_user != null) {
                if (_items != null) {
                  setState(() {
                    _items!.clear();
                    _items = null;
                  });
                }
                _favoriteBloc.page = 1;
                _favoriteBloc.add(FetchFavoriteEvent(user: _user!));
              }
            },
            child: BlocListener<FavoriteBloc, FavoriteState>(
                listener: (context, state) {
              if (state is FavoriteErrorState) {

                _items = [];
                // showToast(state.error!, context);
                // BlocProvider.of<FavoriteBloc>(context).isFetching = false;
              }

              if (state is FavoriteSuccessState) {
                print(state.items![0].product);
                _items = [];
                _items!.addAll(state.items!);
                // BlocProvider.of<FavoriteBloc>(context).isFetching = false;
              }
              if (state is RemoveFromFavoriteSuccessState) {
                setState(() {
                  _items!.removeWhere(
                      (element) => element.product!.id == state.productId);
                });
                Fluttertoast.showToast(msg: state.message!);
              }
            }, child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
              return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    _items == null
                        ? SliverToBoxAdapter(
                            child: StaggeredGridView.countBuilder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 24),
                                shrinkWrap: true,
                                primary: false,
                                crossAxisCount: 4,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                staggeredTileBuilder: (int x) =>
                                    StaggeredTile.count(2, x.isEven ? 4 : 3),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        ProductVerEmptyWidget(),
                                itemCount: 4))
                        : _items!.length == 0
                            ? CenterWidgetListSliver(
                                label: "your wishlist is currently empty")
                            : SliverToBoxAdapter(
                                child: Column(children: [
                                // SizedBox(height: 16),
                                GridView.count(
                                    childAspectRatio: 1 / 1.5,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    shrinkWrap: true,
                                    primary: false,
                                    children:
                                        List.generate(_items!.length, (index) {
                                      return FavoriteWidget(
                                          model: _items![index],
                                          onFavTap: () =>
                                              _onFavTap(_items![index]));
                                    }))
                              ])),
                  ]);
            }))));
  }

  _onFavTap(FavoriteModel model) {
    _favoriteBloc
      ..add(
          RemoveFromFavoriteEvent(user: _user!, favoriteId: model.product!.id!));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
