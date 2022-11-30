import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_translate/flutter_translate.dart';
import 'package:hand_bill/src/blocs/Services/bloc.dart';
import 'package:hand_bill/src/blocs/Services/states.dart';
// import 'package:hand_bill/src/blocs/other_company/other_company_state.dart';
// import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/category/sub_category.dart';
// import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';
import 'package:hand_bill/src/data/response/banner/banner_service_response.dart';
// import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/search_service/shipping_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/shipping_widget.dart';
// import 'package:hand_bill/src/ui/screens/common/services_company_widget/customs_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_empty_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_widget.dart';
// import 'package:hand_bill/src/ui/screens/services_package/shipping/shipping_widget.dart';
// import 'package:hand_bill/src/ui/screens/services_package/shipping/subShipping_Screen.dart';

// import '../../../../blocs/Services/Event.dart';
// import '../../../../blocs/Services/states.dart';
// import '../../../../blocs/category/category_bloc.dart';
import '../../../../blocs/Services/Event.dart';
import '../../../../blocs/category/category_event.dart';
import '../../../../common/constns.dart';
import '../../../../data/model/category/sub_sub.dart';
import '../../../../data/model/local/route_argument.dart';
import '../../navigation_package/categories/component/category_empty_widget.dart';
import '../../navigation_package/categories/component/category_widget.dart';
import 'Service_first_company.dart';
// import '../../../../blocs/category/category_state.dart';
// import '../../../../data/model/local/route_argument.dart';
// import '../../navigation_package/categories/component/sub_category_widget.dart';
// import '../../navigation_package/categories/sub_category_screen.dart';

class ServiceScreen extends StatefulWidget {

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen>
    with SingleTickerProviderStateMixin {

  List<GetDataCategory>? _categories;

  List<SubCategoryModel>? _subCategories;

  ScrollController? _scrollController;
  double offsetVisibleThreshold = 100;

  GetDataCategory? _selectedCategory;
  ServiceBlocData? _serviceBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  get categories => null;
  @override
  void initState() {
    _serviceBloc = BlocProvider.of<ServiceBlocData>(context);
    _serviceBloc!..add(FetchServiceEvent());

    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  bool _showRealLength = false;
  int? _showRealSubLengthIndex;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: BlocListener<ServiceBlocData, ServiceState>(
            listener: (context, state) {
              if (state is CategoryErrorState) {
                _categories = [];
                SchedulerBinding.instance?.addPostFrameCallback((_) {
                  displaySnackBar(
                      title: state.errors, scaffoldKey: _scaffoldKey);
                });
              }
              if (state is CategoriesSuccessState) {
                if (_categories == null) {
                  _categories = [];

                } else {}
              }

              if (state is SubCategoriesSuccessStatee) {
                if (_subCategories == null) {
                  _subCategories = [];
                }
                if (_selectedCategory != null &&
                    state.items != null &&
                    state.items!.length != 0) {
                  if (_showRealLength == false) {
                    SchedulerBinding.instance?.addPostFrameCallback((_) {
                      setState(() {
                        _showRealLength = true;
                      });
                    });
                  }
                  if (_subCategories!.length != 0 &&
                      _subCategories!.first.id != state.items!.first.id) {
                    _subCategories!.addAll(state.items!);
                  } else if (_subCategories!.length == 0) {
                    _subCategories!.addAll(state.items!);
                  }
                }
              }
            },

            child: ListView(children: [
              GridView.count(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
                  childAspectRatio: 1 / 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  shrinkWrap: true,
                  primary: false,
                  children:
                      List.generate(_serviceBloc!.categories!.length, (index) {
                    return ShippingWidget(
                        model: _serviceBloc!.categories![index],
                        onTap: () =>
                            onCategoryTap(_serviceBloc!.categories![index]));
                  })),
              SizedBox(height: 80),
            ]),
          ),
        ));

  }
  onCategoryTap(
      GetDataCategory serviceCategoryModel,
  ) {
    if (_serviceBloc!.categories!.first.selectedd == true) {
      _serviceBloc!.categories!.first.selectedd = false;
    }
    setState(() {
    if (_selectedCategory != null) {
       _selectedCategory!.selectedd = false;
    }});
    if (_subCategories != null) _subCategories!.clear();
    setState(() {
      _showRealLength = false;
      _showRealSubLengthIndex = -100;
      // _serviceBloc!.isPaginationFinished = false;
       serviceCategoryModel.selectedd = !serviceCategoryModel.selectedd!;
      _selectedCategory = serviceCategoryModel;
       _serviceBloc!.subCatPage = 1;
        print('eeeee');
      Navigator.pushNamed(context, ServiceFirstCompany.routeName,
          arguments: RouteArgument(
              param: serviceCategoryModel.name,
              id: serviceCategoryModel.id.toString()));
    });
    // _categoryBloc!
    //     .add(FetchSubCategoriesEvent(categoryId: categoryModel.id.toString()));
    // });
  }
    //   GetDataCategory serviceCategoryModel,) {
    // if (_serviceBloc!.categories!.first.selectedd == true) {
    //   _serviceBloc!.categories!.first.selectedd = false;
    // }
    // setState(() {
    //   if (_selectedCategory != null) {
    //     _selectedCategory!.selectedd = false;
    //   }
    //   if (_subCategories != null) _subCategories!.clear();
    //   setState(() {
    //     _showRealLength = false;
    //     _showRealSubLengthIndex = -100;
    //     serviceCategoryModel.selectedd = !serviceCategoryModel.selectedd!;
    //     _selectedCategory = serviceCategoryModel;
    //     _serviceBloc!.subCatPage = 1;
    //
    //     Navigator.pushNamed(context, ShippingScreen.routeName,
    //         arguments: RouteArgument(
    //             param: serviceCategoryModel.name.toString(),
    //             id: serviceCategoryModel.id.toString()));
    //   });
      // _serviceBloc!
      //     .add(FetchSubCategoriesEvent(categoryId: categoryModel.id.toString()));
      // });
    // });}


  Widget builditem() => ListView(children: [
        GridView.count(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
            childAspectRatio: 1 / 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            shrinkWrap: true,
            primary: false,
            children: List.generate(_serviceBloc!.categories!.length, (index) {
              return ShippingWidget(
                  model: _serviceBloc!.categories![index],
                  onTap: () => onCategoryTap(_serviceBloc!.categories![index]));
            })),
        SizedBox(height: 80),
      ]);
}
