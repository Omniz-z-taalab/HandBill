import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/patents/patents_bloc.dart';
import 'package:hand_bill/src/blocs/patents/patents_event.dart';
import 'package:hand_bill/src/blocs/patents/patents_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/services/patented_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patented_add_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';

import 'component/patented_widget.dart';

class MyPatentsScreen extends StatefulWidget {
  static const routeName = "/MyPatentsScreen";

  @override
  _MyPatentsScreenState createState() => _MyPatentsScreenState();
}

class _MyPatentsScreenState extends State<MyPatentsScreen> {
  List<PatentedModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late PatentsBloc _patentsBloc;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;
  User? _user;

  @override
  void initState() {
    _patentsBloc = BlocProvider.of<PatentsBloc>(context);
    _scrollController = ScrollController()..addListener(_onScroll);

    _user = BlocProvider.of<GlobalBloc>(context).user;
    if (_user != null) {
      _patentsBloc.add(FetchMyPatentsEvent(user: _user!));
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyPatentsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
    final max = _scrollController!.position.maxScrollExtent;
    final offset = _scrollController!.offset;

    if (offset + offsetVisibleThreshold >= max && !_patentsBloc.isFetching) {
      setState(() {
        _patentsBloc.isFetching = true;
      });
      _patentsBloc.add(FetchPatentsEvent());
    }
  }

  double iconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: RegularAppBar(label: "My_Patents".tr()),
        floatingActionButton: FloatingActionButton(
            backgroundColor: mainColorLite,
            onPressed: () {
              Navigator.pushNamed(context, PatentedAddScreen.routeName);
            },
            child: Icon(Icons.add)),
        backgroundColor: Color(0xffeeeeee),
        body:
            BlocConsumer<PatentsBloc, PatentsState>(listener: (context, state) {
          if (state is PatentsErrorState) {
            _items = [];
            Fluttertoast.showToast(
                msg: state.error ?? '',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is MyPatentsSuccessState) {
            print(state.items!.first.title);
            print('ssssssssssssss');
            _items = state.items!;
          }

          if (state is PatentedRemoveSuccessState) {
            setState(() {
              _items!.removeWhere((element) => element.id == state.model.id);
            });
            Fluttertoast.showToast(
                msg: state.message ?? '',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }, builder: (context, state) {
          return RefreshIndicator(
              onRefresh: () async {
                if (_items != null) {
                  _items!.clear();
                  _items = null;
                }
                _patentsBloc.myPage = 1;
                _patentsBloc.add(FetchMyPatentsEvent(user: _user!));
              },
              child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: _scrollController,
                  slivers: [
                    _items == null
                        ? SliverToBoxAdapter(
                            child:Padding(
                              padding: const EdgeInsets.only(top: 80.0),
                              child: Center(child: CircularProgressIndicator(),),
                            ),

                          )
                        : _items!.length == 0
                            ? CenterWidgetListSliver(
                                label: "your patents is empty".tr())
                            : SliverToBoxAdapter(
                                child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    // padding: EdgeInsets.symmetric(vertical: 16),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: _items!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return PatentedWidget(
                                        model: _items![index],
                                        onDeleteTap: () =>
                                            _deleteItem(_items![index]),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Container(
                                                height: 10,
                                                color: Color(0xffeeeeee)))),
                    SliverToBoxAdapter(child: SizedBox(height: 100)),
                    SliverToBoxAdapter(
                        child: Container(
                            child: loading == true
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 40),
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2)))
                                : SizedBox()))
                  ]));
        }));
  }

  void _deleteItem(PatentedModel model) {
    _patentsBloc.add(PatentedRemoveEvent(user: _user!, model: model));
  }
}
