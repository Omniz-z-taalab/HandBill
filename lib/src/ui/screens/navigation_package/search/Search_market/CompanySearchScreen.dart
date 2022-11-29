import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';

import '../../../../../blocs/company/company_bloc.dart';
import '../../../../../common/constns.dart';
import '../../../../../data/model/category/category.dart';
import '../../../../../data/model/company.dart';
import '../../../../../data/model/product.dart';
import '../../../../../data/model/user.dart';

class CompanySearchScreen extends StatefulWidget {
  static const routeName = "/CompanySearchScreen";
  final RouteArgument routeArgument;

  const CompanySearchScreen({required this.routeArgument});

  @override
  State<CompanySearchScreen> createState() => _CompanySearchScreenState();
}

class _CompanySearchScreenState extends State<CompanySearchScreen> {
  Company? _company;
  String? savedId;
  List<Product> featuredList = [], productsList = [];
  List<CategoryModel> categories = [];
  late CompanyBloc _companyBloc;
  int cartCount = 0;
  User? _user;
  late final int? id;

  @override
  void initState() {
    id = widget.routeArgument.param;
    print(id.toString());
    print(widget.routeArgument.param);
    _companyBloc = BlocProvider.of<CompanyBloc>(context);
    _companyBloc.add(FetchCompanyDetails(id: id.toString()));
    _companyBloc.add(FetchFeaturedProductCompany(id: id.toString()));
    _companyBloc.add(FetchCompanyProducts(companyId: id.toString()));

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Back',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: BlocConsumer<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is GetCompanySuccessState) {
            setState(() {
              _company = state.company!;
              print('qwww');
            });
          }
          if (state is GetCompanyCategoriesSuccessState) {
            setState(() {
              categories.addAll(state.items!);
            });
          }
          if (state is GetFeaturedProductCompanySuccessState) {
            setState(() {
              featuredList.addAll(state.items!);
              _companyBloc!.isFetching = false;
            });
          }

          if (state is GetCompanyProductsSuccessState) {
            setState(() {
              productsList.addAll(state.items!);
            });
          }
          if (state is CompanyErrorState) {
            Fluttertoast.showToast(msg: state.error.toString());
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  _company == null
                      ? Container()
                      : Center(
                          child: Container(
                              height: 150,
                              width: 400,
                              color: Colors.white,
                              child: CachedNetworkImage(
                                  width: 370,
                                  // height: 200,
                                  imageUrl: _company!.flag == null
                                      ? placeholder
                                      : '${_company!.flag}',
                                  placeholder: (context, url) => Center(
                                      heightFactor: 1,
                                      widthFactor: 1,
                                      child: CircularProgressIndicator(
                                          color: mainColorLite,
                                          strokeWidth: 1)),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error,
                                          color: mainColorLite))),
                        ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(''),
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
