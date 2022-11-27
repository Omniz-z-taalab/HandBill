import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/search_service/widgets/search_category_service.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/search_service/widgets/search_company.dart';

import '../../../../../blocs/Services/Event.dart';
import '../../../../../blocs/Services/bloc.dart';
import '../../../../../blocs/Services/states.dart';
import '../../../../../blocs/search/search_bloc.dart';
import '../../../../../common/constns.dart';
import '../../../../../data/model/company.dart';

class SearchSuppliers extends StatefulWidget {
  @override
  State<SearchSuppliers> createState() => _SearchSuppliersState();
}

class _SearchSuppliersState extends State<SearchSuppliers> {
  ServiceBlocData? serviceBloc;
  SearchBloc? searchBloc;
  FocusNode focusNode = FocusNode();
  List<ServiceModel>? items;
  final _searchController = TextEditingController();
  final double size = 20;
  int selectedPage = 0;
  List<Company>? companies;

  @override
  void initState() {
    serviceBloc = BlocProvider.of<ServiceBlocData>(context);
    serviceBloc!.add(FetchData());
    // serviceBloc!.add(SearchMarketEvent(searchKey: _searchController.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onSubmitted(value) async {
      if (_searchController.text.length >= 1) {
          serviceBloc!..add(SearchMarketEvent(searchKey: value));
      }
    }

    Color borderColor = Color(0xffeeeeee);

    return Scaffold(
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
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {
                  _onSubmitted(value.trim());

                  if (_searchController!.text.isEmpty!) {
                    setState(() {
                      companies!.clear();
                    });
                  }
                },
                style: TextStyle(color: textLiteColor),
                decoration: InputDecoration(
                    prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset("assets/icons/search_ic.svg",
                            height: size, width: size)),
                    hintText: "suppliers".tr(),
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
                controller: _searchController,
                textInputAction: TextInputAction.go,
                // onSubmitted: (value) => _onSubmitted(value.trim()),
                focusNode: focusNode),
          )),
      body: BlocConsumer<ServiceBlocData, ServiceState>(
          listener: (context, state) {
        // if(state is)
        if (state is categorySuccessState) {
          items = state.items;
        }
        if (state is searchSuccess) {
          companies = state.company;
        }
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [
              _searchController.text.isEmpty
                  ? Container(

              )
                  : companies == null
                      ? Container(
                          height: 100,
                          width: 400,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off_sharp,
                                color: Colors.red,
                                size: 30,
                              ),
                              Text(
                                'Search_is_empty'.tr(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 170,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: ListView.separated(
                                itemBuilder: (context, index) =>
                                    SearchCompany(companies![index], context),
                                itemCount: companies!.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                  height: 1,
                                  width: 20,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
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
              items == null
                  ? Padding(
                      padding: const EdgeInsets.all(120.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SingleChildScrollView(
                      child: SizedBox(
                        height: 600,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: ListView.separated(
                              itemBuilder: (context, index) =>
                                  ServiceCompany(items![index], context),
                              itemCount: items!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ]),
          ),
        );
      }),
    );
  }
}
