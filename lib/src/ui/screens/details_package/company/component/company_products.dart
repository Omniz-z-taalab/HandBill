import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/company/company_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_bloc.dart';
import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/company/company_category_widget.dart';
import 'package:hand_bill/src/ui/component/product/product_hor_empty_widget.dart';
import 'package:hand_bill/src/ui/component/product/product_hor_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/home/componenet/home_label.dart';

class CompanyProducts extends StatefulWidget {
  final List<Product> products ;
  final  List<Product> featuredList ;
  final List<CategoryModel> categories ;

  CompanyProducts(
      {required this.products,
      required this.featuredList,
      required this.categories});

  @override
  _CompanyProductsState createState() => _CompanyProductsState();
}

class _CompanyProductsState extends State<CompanyProducts>
    with AutomaticKeepAliveClientMixin {
  List<Product> _products = [];

  List<Product>? _featuredList;

  late CompanyBloc _companyBloc;
  ScrollController? _scrollController;
  User? _user;
  static const offsetVisibleThreshold = 50.0;
  late Company _company;

  late FavoriteBloc _favoriteBloc;
  List<CategoryModel>? _categories;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _companyBloc = BlocProvider.of<CompanyBloc>(context);

    _scrollController = ScrollController()..addListener(_onScroll);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CompanyProducts oldWidget) {
    if (widget.featuredList != null) {
      _featuredList = [];
      if (_featuredList!.length > 0) {
        _featuredList!.clear();
        _featuredList!.addAll(widget.featuredList);
      } else {
        _featuredList!.addAll(widget.featuredList);
      }
    }
    if (widget.categories.isNotEmpty) {
      _categories = [];
      _categories!.clear();
      _categories!.addAll(widget.categories);
    }
    if (widget.products.isNotEmpty) {
      _products.clear();
      _products.addAll(widget.products);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onScroll() {
    final max = _scrollController!.position.maxScrollExtent;
    final offset = _scrollController!.offset;

    if (offset + offsetVisibleThreshold >= max && !_companyBloc.isFetching) {
      setState(() {
        _companyBloc.isFetching = true;
      });
      _companyBloc.add(FetchCompanyProducts(companyId: _company.id.toString()));
    }
  }

  void _onCategorySelect(int index) {
    setState(() {
      if (_selectedCategory != null) {
        _selectedCategory!.selected = false;
      }
      _categories![index].selected = !_categories![index].selected!;
      _selectedCategory = _categories![index];
      if (_products != null) {
        _products.clear();
      }

      _companyBloc.page = 1;
      _companyBloc
          .add(FetchCompanyCategories(id: _selectedCategory!.id.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          _featuredList == null
              ? SliverToBoxAdapter()
              : _featuredList!.length == 0
                  ? SliverToBoxAdapter()
                  : HomeLabel(title: "FeaturedProducts".tr()),
          SliverToBoxAdapter(
              child: _featuredList == null
                  ? Container(
                      height: size.height * 0.38,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return ProductHorEmptyWidget();
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(width: 6)))
                  : _featuredList!.length == 0
                      ? SizedBox()
                      : Container(
                          height: size.height * 0.38,
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 8),
                              scrollDirection: Axis.horizontal,
                              itemCount: _featuredList!.length,
                              itemBuilder: (context, index) {
                                return ProductHorWidget(
                                    model: _featuredList![index],
                                    user: _user,
                                    isHome: true,
                                    favoriteBloc: _favoriteBloc,
                                    canFav: false);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(width: 6)))),
          SliverToBoxAdapter(
              child: _categories == null
                  ? SizedBox()
                  : Container(
                      height: size.height * 0.05,
                      margin: EdgeInsets.only(top: 6, bottom: 8),
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MarketCategoryWidget(
                                model: _categories![index],
                                onTap: () => _onCategorySelect(index));
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(width: 8)))),
          if(_products.isNotEmpty) HomeLabel(title: "Products"),
          if(_products.isNotEmpty) SliverToBoxAdapter(
            child: Container(
                width: double.infinity,
                height: size.height * 0.35,
                child: ListView.separated(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    scrollDirection: Axis.horizontal,
                    itemCount: _products.isNotEmpty ? _products.length : 6,
                    itemBuilder: (context, index) {
                      // if (_companyBloc.isFetching == true) {
                      //   return ProductHorEmptyWidget();
                      // }
                      if (_products.isNotEmpty) {
                        return ProductHorWidget(
                            model: _products[index],
                            user: _user,
                            favoriteBloc: _favoriteBloc,
                            canFav: false);
                      }
                        return ProductHorEmptyWidget();
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(width: 8))
            ),
          ),
        ]);
  }

  @override
  bool get wantKeepAlive => true;
}

// Padding(
// padding: ,
// child: Text("no data founded!",style: TextStyle(
// color: Colors.red,fontSize: 12,
// ),),
// ),