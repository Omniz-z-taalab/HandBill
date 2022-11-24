import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/category/category_bloc.dart';
import 'package:hand_bill/src/blocs/category/category_event.dart';
import 'package:hand_bill/src/blocs/explore/explore_bloc.dart';
import 'package:hand_bill/src/blocs/explore/explore_event.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_state.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/home/home_bloc.dart';
import 'package:hand_bill/src/blocs/home/home_event.dart';
import 'package:hand_bill/src/blocs/home/home_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/company/company_empty_widget.dart';
import 'package:hand_bill/src/ui/component/company/company_home.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/home/componenet/slider_empty_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/home/componenet/slider_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc? _homeBloc;

  double marginVertical = 24;
  User? _user;
  int _sliderPosition = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // FavoriteBloc? _favoriteBloc;
  CategoryBloc? _categoryBloc;
  ExploreBloc? _exploreBloc;
  @override
  void didChangeDependencies() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    // _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _user = BlocProvider.of<GlobalBloc>(context).user;
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    if (_categoryBloc!.categories == null ||
        _categoryBloc!.categories!.length == 0)
      _categoryBloc!..add(FetchCategoriesEvent());
    // if (_categoryBloc!.subCategories == null ||
    //     _categoryBloc!.subCategories!.length == 0 &&
    //         _categoryBloc!.categories!.isNotEmpty &&
    //         _categoryBloc!.categories != null)
    //   _categoryBloc!
    //     ..add(FetchSubCategoriesEvent(
    //         categoryId: _categoryBloc!.categories!.first.id.toString()));
    // _exploreBloc = BlocProvider.of<ExploreBloc>(context);
    // _exploreBloc!.add(FetchExploreEvent());
    // if(_exploreBloc!.items!=null&&_exploreBloc!.items!.length!=0){
    //   _exploreBloc!.items!.forEach((element) {
    //     _exploreBloc!.controllers.add(VideoPlayerController.network(element.link!));
    //   });
    // }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // _exploreBloc!.controllers.forEach((controller) {
    //   controller.dispose();
    // });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),

      key: _scaffoldKey,
      body: RefreshIndicator(
          onRefresh: () async {
            _homeBloc!.sliders.clear();
            _homeBloc!.topCompaniesList.clear();
            _homeBloc!.popularList.clear();
            _homeBloc!.add(HomeFetchSliders());
            _homeBloc!.add(HomeFetchTopCompanies());
            _homeBloc!.add(HomeFetchPopular());
          },
          child: MultiBlocListener(
              listeners: [
                BlocListener<HomeBloc, HomeState>
                  (listener: (context, state) {
                  if (state is SliderLoadingState) {
                  } else if (state is SliderErrorState) {
                    displaySnackBar(
                        title: state.errors, scaffoldKey: _scaffoldKey);
                  } else if (state is SliderSuccessState) {
                    if (_homeBloc!.sliders == [])
                      _homeBloc!.sliders.addAll(state.items!);
                  }
                  if (state is TopCompaniesLoadingState) {
                  } else if (state is TopCompaniesErrorState) {
                    displaySnackBar(
                        title: state.errors, scaffoldKey: _scaffoldKey);
                  } else if (state is TopCompaniesSuccessState) {
                    if (_homeBloc!.topCompaniesList == [])
                      _homeBloc!.topCompaniesList.addAll(state.items!);
                  }
                  if (state is PopularLoadingState) {
                  } else if (state is PopularErrorState) {
                    displaySnackBar(
                        title: state.errors, scaffoldKey: _scaffoldKey);
                  } else if (state is PopularSuccessState) {
                    if (_homeBloc!.popularList == [])
                      _homeBloc!.popularList.addAll(state.items!);
                  }
                }),
                BlocListener<FavoriteBloc, FavoriteState>(
                    listener: (context, state) {
                  if (state is AddToFavoriteSuccessState) {
                    _homeBloc!.popularList.forEach((element) {
                      if (element.id == state.favoriteId) {
                        setState(() {
                          element.isFavourite = '0';
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
                        fontSize: 16.0
                    );
                  }
                  if (state is RemoveFromFavoriteSuccessState) {
                    _homeBloc!.popularList.forEach((element) {
                      if (element.id == state.productId) {
                        setState(() {
                          element.isFavourite = '1';
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
                        fontSize: 16.0
                    );
                  }
                })
              ],
              child: ListView(physics: BouncingScrollPhysics(), children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                       CarouselSlider.builder(
                              itemCount: _homeBloc!.sliders.isNotEmpty
                                  ? _homeBloc!.sliders.length
                                  : 6,
                              itemBuilder:
                                  (BuildContext context, int index, int idx) {
                                if (_homeBloc!.sliders.isNotEmpty) {
                                  return SliderWidget(
                                      model: _homeBloc!.sliders[index]);
                                }
                                return SliderEmptyWidget();
                              },
                              options: CarouselOptions(
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  // enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: true,
                                  enableInfiniteScroll: true,
                                  autoPlayInterval:
                                      Duration(milliseconds: 4000),
                                  autoPlayCurve: Curves.easeOutSine,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _sliderPosition = index;
                                    });
                                  }),),
                      _homeBloc!.sliders.isEmpty
                          ? SizedBox()
                          : Positioned(
                              bottom: 8,
                              right: 0,
                              left: 0,
                              child: DotsIndicator(
                                  dotsCount: _homeBloc!.sliders.length,
                                  position: _sliderPosition.toDouble(),
                                  decorator: DotsDecorator(
                                      color: Color(0xffffffff),
                                      activeColor: mainColorLite,
                                      size: const Size(6.0, 4.0),
                                      activeSize: const Size(12.0, 4.0),
                                      activeShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0))))),
                    ],
                  ),
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                    scrollDirection: Axis.vertical,
                    itemCount: _homeBloc!.topCompaniesList.isNotEmpty
                        ? _homeBloc!.topCompaniesList.length
                        : 6,
                    itemBuilder: (context, index) {
                      if (index < _homeBloc!.topCompaniesList.length) {
                        return CompanyHorWidget(
                            model: _homeBloc!.topCompaniesList[index],
                            isHome: true);
                      }
                      return MarketEmptyWidget();
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 5)),
              ]))),
    );
  }
}
