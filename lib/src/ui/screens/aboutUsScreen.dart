// ignore_for_file: unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/category/category_bloc.dart';

import '../../blocs/about_us_bloc/about_us_bloc.dart';
import '../../data/model/about_us/aboutUsModel.dart';

class AboutUsScreen extends StatefulWidget {
  static const routeName = "/AboutUsScreen";

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  bool loading = false;

  // AboutUsBloc? aboutUsBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<AboutUsModel>? _list;
  ScrollController? _scrollController;
  late AboutUsBloc aboutUsBloc;
  CategoryBloc? _categoryBloc;

  @override
  void initState() {
    aboutUsBloc = BlocProvider.of<AboutUsBloc>(context);
    aboutUsBloc.add(FetchAboutItemEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AboutUsBloc, AboutUsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
              child: SizedBox(
                  height: 900,
                  width: double.infinity,
                  child: Scaffold(
                      appBar: AppBar(
                          leading: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          backgroundColor: Colors.white,
                          title: Text(
                            'AboutUs'.tr(),
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )),
                      body: SingleChildScrollView(
                          child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            height: 150,
                            width: 400,
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            'Video'.tr(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Container(
                            height: 150,
                            width: 400,
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            'About US Videos '.tr(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView(children: [
                            GridView.count(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
                                childAspectRatio: 1 / 0.7,
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                                shrinkWrap: true,
                                primary: false,
                                children: List.generate(4, (index) {
                                  return Container(
                                    color: Colors.amber,
                                    height: 100,
                                    width: 200,
                                  );
                                })),
                            SizedBox(height: 80),
                          ]),
                        )
                      ])))));
        });
  }
}
