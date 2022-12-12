import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hand_bill/src/blocs/favorite/favorite_bloc.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/search/search_bloc.dart';
import 'package:hand_bill/src/blocs/search/search_event.dart';
import 'package:hand_bill/src/blocs/search/search_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/common/global.dart';
import 'package:hand_bill/src/data/model/local/tab_toggle_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';

import '../../../../data/response/search/search_product_response.dart';


class SearchScreen extends StatefulWidget {
  static const routeName = "/searchScreen";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<DataProductSearch>? _products = [];
  List<DataCompanySearch>? _companies = [];

  User? _user;

  final _searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late SearchBloc _searchBloc;

  double marginVertical = 24;

  List<TabToggleModel> labelList = [
    TabToggleModel(label: "search.products".tr()),
    TabToggleModel(label: "search.suppliers".tr())
  ];

  int selectedPage = 0,
      _cartCount = 0;
  bool gridOrList = true;

  final double size = 20;

  late FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _searchBloc.page = 1;

    // focusNode.requestFocus();

    // getRecentSearch();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getUser();
    super.didChangeDependencies();
  }

  getUser() {
    _user = BlocProvider.of<GlobalBloc>(context).user;
    if (_user != null) {
      setState(() {});
    }
  }


  // @override
  // void dispose() {
  //   _searchBloc.close();
  //   super.dispose();
  // }

  getRecentSearch() async {
    try{
      recentSearchProduct = await storage.read(key: "recentSearchProduct");
      recentSearchMarket = await storage.read(key: "recentSearchMarket");
      if (recentSearchProduct == null) {
        _searchBloc.add(SearchProductEvent(searchKey: ""));
      } else {
        _searchBloc.add(SearchProductEvent(searchKey: recentSearchProduct));
      }
      if (recentSearchMarket == null) {
        // _searchBloc.add(SearchMarketEvent(searchKey: ""));
      // } else {
      //   _searchBloc.add(SearchMarketEvent(searchKey: recentSearchMarket));
      }
    }catch(e){print(e.toString());}
  }

  @override
  Widget build(BuildContext context) {
      _onSubmitted(value) async {
      if (_searchController.text.length >= 3) {
        if (selectedPage == 0) {
          _searchBloc.add(SearchProductEvent
            (searchKey: value));
        } else {
          // _searchBloc.add(SearchMarketEvent(searchKey: value));
        }
      }
    }

    Color borderColor = Color(0xffeeeeee);
    return Scaffold(backgroundColor: Color(0xfffafafa),
        appBar: RegularAppBar(
            label: "search.search",
            widget: InkWell(
            onTap: () {
              setState(() {
                gridOrList = !gridOrList;
              });
            },
            child: Container(
                padding: EdgeInsets.all(12),
                child: Icon(
                    gridOrList == false
                        ? Icons.list_outlined
                        : Icons.grid_view,
                    color: Colors.black
                )))),
        body: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _products = [];
                _companies = [];
                _products!.clear();
                _companies!.clear();
                _searchController.clear();
              });
              focusNode.unfocus();
               getRecentSearch();
            },
            child: MultiBlocListener(
                listeners: [BlocListener<SearchBloc, SearchState>(listener:
                    (context, state) async {
                  if (state is SearchProductsErrorState) {
                    // showToast(state.error, context);
                    _searchBloc.isFetching = false;
                  }

                  if (state is SearchProductsSuccessState) {
                    if (state.products!.products!.data!.isEmpty!) {
                      _products = null;
                    } else {
                      _products = [];
                      _products!.clear();
                      // _products!.addAll(state.products!);
                      if (_searchController.text.isNotEmpty) {
                        await storage.write(key: "recentSearchProduct",
                            value: _searchController.text);
                      }
                    }
                    _searchBloc.isFetching = false;
                  }
                  if (state is SearchCompaniesSuccessState) {
                    if (state.companies!.isEmpty) {
                      _companies = null;
                    } else {
                      _companies = [];
                      _companies!.clear();
                      _companies!.addAll(state.companies!);

                      if (_searchController.text.isNotEmpty) {
                        await storage.write(key: "recentSearchMarket",
                            value: _searchController.text);
                      }
                    }
                    _searchBloc.isFetching = false;
                  // }
                }}),

                ],
    child: Container(),
    )));}}
  Widget NoResultsWidget() {
    return SliverToBoxAdapter(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
                child: Text("there are no results search",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: textLiteColor, height: 1.5),
                    textAlign: TextAlign.center))));
  }

