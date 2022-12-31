import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_bill/src/blocs/search/search_event.dart';
import 'package:hand_bill/src/blocs/search/search_state.dart';
import 'package:hand_bill/src/common/api_data.dart';

import 'package:hand_bill/src/ui/screens/navigation_package/search/Search_market/sub_categoies_screen.dart';
import '../../../../../blocs/search/search_bloc.dart';
import '../../../../../common/constns.dart';
import '../../../../../data/model/local/route_argument.dart';
import '../../../../../data/model/local/tab_toggle_model.dart';
import '../../../../../data/response/search/search_categories_response.dart';
import '../../../../../data/response/search/search_product_response.dart';
import '../../../../component/custom/custom_tab_toggle.dart';
import '../../../../component/custom/login_first_widget_sliver.dart';

import 'Widgets/SearchCompany_widget.dart';
import 'Widgets/SearchProduct_widget.dart';

class SearchByCategoriesScreen extends StatefulWidget {
  const SearchByCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<SearchByCategoriesScreen> createState() =>
      _SearchByCategoriesScreenState();
}

class _SearchByCategoriesScreenState extends State<SearchByCategoriesScreen> {
  late SearchBloc _searchBloc;
  List<SubCategorySearch>? data;
  bool isFetching = false;
  final _searchController = TextEditingController();
  List<TabToggleModel> labelList = [
    TabToggleModel(label: "products".tr()),
    TabToggleModel(label: "company's".tr())
  ];
  bool gridOrList = true;

  final double size = 20;
  int selectedPage = 0;
  FocusNode focusNode = FocusNode();
  List<DataProductSearch>? product;

  List<DataCompanySearch>? companyy;

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc.add(SearchAllCategoriesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onSubmitted(value) async {
      if (_searchController.text.length >= 1) {
        if (selectedPage == 0) {
          _searchBloc.add(SearchProductEvent(searchKey: value));
        }
        if (selectedPage == 1) {
          _searchBloc.add(SearchComEvent(searchKey: value));
        }
        if (_searchController.text.isEmpty) {
          product!.clear();
          product = null;
        } else if (_searchController.text!.isEmpty) {
          companyy!.clear();
        }
        // }
      }
    }

    Color borderColor = Color(0xffeeeeee);

    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: Container(
            width: 370,
            height: 40,
            child: TextField(
                controller: _searchController,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {
                  _onSubmitted(value);
                  if (_searchController.text.isEmpty) {
                    setState(() {
                      if (selectedPage == 0) {
                        product!.clear();
                        product == null;
                      }
                    });
                    setState(() {
                      if (selectedPage == 1) {
                        companyy!.clear();
                        companyy = [];
                      }
                    });
                  }
                },
                style: TextStyle(color: textLiteColor),
                decoration: InputDecoration(
                    prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset("assets/icons/search_ic.svg", height: size, width: size)),
                    hintText: "text".tr(),
                    filled: true,
                    focusColor: mainColor,
                    hintStyle: Theme.of(context).textTheme.headline2,
                    fillColor: Color(0xffffffff),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(color: borderColor, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: borderColor, width: 1))),
                textInputAction: TextInputAction.go,
                onSubmitted: (value) => _onSubmitted(value.trim()),
                focusNode: focusNode),
          )),
      body: SizedBox(
        height: 900,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
                child: CustomTabToggle(
                    items: labelList,
                    initIndex: selectedPage,
                    onIndexChanged: (index) {
                      setState(() {
                        selectedPage = index;
                        print(selectedPage);
                      });
                    }),
              ),
              SizedBox(
                height: 600,
                child: BlocConsumer<SearchBloc, SearchState>(
                    listener: (context, state) {
                  if (state is SearchProductsSuccessState) {
                    if (state.products!.products!.data!.isEmpty) {
                      product = null;
                    }
                    if (product == null) {
                      product = [];
                    } else {
                      product = state.products!.products!.data!;
                      print('pppppppp');
                      // _searchBloc.isFetching = false;
                    }
                  }
                  if (state is SearchcompanySuccessState) {
                    if (state.products!.companies!.data!.isEmpty) {
                      companyy = null;
                    }
                    if (companyy == null) {
                      companyy = [];
                    } else {
                      companyy = state.products!.companies!.data!;
                      print('aaaaaaaa');
                    }
                  }
                  if (state is SearchCategoriesSuccessState) {
                    if (state.products!.isEmpty) {
                      data = null;
                    } else {
                      data = [];
                      data!.clear();
                      data!.addAll(state.products!);
                      _searchBloc.isFetching = false;
                    }
                  }
                }, builder: (context, state) {
                  return SingleChildScrollView(
                      child: SafeArea(
                          child: Column(children: [
                    Column(
                      children: [
                        selectedPage == 0
                            ? Column(children: [
                                _searchController.text.isEmpty
                                    ? Container(
                                        height: 10,
                                      )
                                    : product == null
                                        ? CircularProgressIndicator()
                                        : product!.length == 0
                                            ? Container(
                                                height: 100,
                                                width: 400,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.search_off_sharp,
                                                      color: Colors.red,
                                                      size: 30,
                                                    ),
                                                    Text(
                                                      'Search_is_empty'.tr(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : SizedBox(
                                                height: 130,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      color: Colors.white38,
                                                      child: ListView.separated(
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return SearchProduct(
                                                              product![index],
                                                              context);
                                                        },
                                                        itemCount:
                                                            product!.length,
                                                        separatorBuilder:
                                                            (BuildContext
                                                                        context,
                                                                    int index) =>
                                                                Container(
                                                          height: 1,
                                                          width:
                                                              double.infinity,
                                                          color: Colors
                                                              .grey.shade300,
                                                        ),
                                                      ),
                                                    ))),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ])
                            : Column(children: [
                                selectedPage == 1 &&
                                        _searchController.text.isEmpty
                                    ? Container(
                                        height: 10,
                                      )
                                    : companyy!.length == 0
                                        ? Container(
                                            height: 100,
                                            width: 400,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.search_off_sharp,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                                Text(
                                                  'Search_is_empty'.tr(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(
                                            height: 130,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  color: Colors.white38,
                                                  child: ListView.separated(
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return SearchCompanyData(
                                                          companyy![index],
                                                          context);
                                                    },
                                                    itemCount: companyy!.length,
                                                    separatorBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            Container(
                                                      height: 1,
                                                      width: double.infinity,
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                  ),
                                                ))),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ])
                      ],
                    ),
                    data == null
                        ? CircularProgressIndicator()
                        : data!.length == 0
                            ? CenterWidgetListSliver(
                                label: "search_is_empty".tr())
                            : Column(
                                children: [
                                  SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Search_by_Category'.tr(),
                                          style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 630,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 600,
                                          width: 520,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SearchCategories(
                                                    model: data![index]);
                                              },
                                              itemCount: data!.length,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                  ])));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchCategories extends StatelessWidget {
  final SubCategorySearch model;
  final bool isHome;

  SearchCategories({required this.model, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      Navigator.pushNamed(context, SubCategoriesScreen.routeName,
          arguments: RouteArgument(param: model.id));
    }, child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          clipBehavior: Clip.antiAlias,
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Color(0xffeeeeee), width: 1.5),
              boxShadow: [
                BoxShadow(
                    color: Color(0xfff5f5f5), blurRadius: 3, spreadRadius: 3)
              ]),
          child: Row(
            children: [
              Expanded(
                child: model.icon == ''
                    ? Container(
                        // height: 50,
                        // width: 50,
                        child: Image.asset(
                          "assets/images/hb_logo.jpeg",
                          height: 60,
                          // width: 20,
                        ),
                      )
                    : Image.network(
                        model.icon.toString(),
                        height: 40,
                      ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  model.name!,
                  style: TextStyle(color: Colors.black),
                ),
              )),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SubCategoriesScreen.routeName,
                        arguments: RouteArgument(param: model.id));
                  },
                  icon: Icon(Icons.arrow_forward_ios))
            ],
          ));
    }));
  }
}
