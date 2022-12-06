import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/hand_made/hand_made_bloc.dart';
import 'package:hand_bill/src/blocs/hand_made/hand_made_event.dart';
import 'package:hand_bill/src/blocs/hand_made/hand_made_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/services/handmade_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/hand_made/component/hand_made_widget.dart';
import 'package:hand_bill/src/ui/screens/services_package/hand_made/handmade_add_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';

class MyHandmadeScreen extends StatefulWidget {
  static const routeName = "/MyHandmadeScreen";

  @override
  _MyHandmadeScreenState createState() => _MyHandmadeScreenState();
}

class _MyHandmadeScreenState extends State<MyHandmadeScreen> {
  List<HandmadeModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late HandmadeBloc _handmaneBloc;
  User? _user;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;

  @override
  void initState() {
    _handmaneBloc = BlocProvider.of<HandmadeBloc>(context);
    _scrollController = ScrollController()..addListener(_onScroll);
      print('zzzzzzz');
    _user = BlocProvider.of<GlobalBloc>(context).user;
    if (_user == null) {
      Fluttertoast.showToast(
          msg:' Login first',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0

      );
      Navigator.pop(context);
    }else{
      _handmaneBloc.add(FetchMyHandmadeEvent(user: _user!));
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
    final max = _scrollController!.position.maxScrollExtent;
    final offset = _scrollController!.offset;

    if (offset + offsetVisibleThreshold >= max && !_handmaneBloc.isFetching) {
      setState(() {
        _handmaneBloc.isFetching = true;
      });
      _handmaneBloc.add(FetchMyHandmadeEvent(user: _user!));
    }
  }

  double iconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: RegularAppBar(label: "My Handmade"),
        floatingActionButton: FloatingActionButton(
            backgroundColor: mainColorLite,
            onPressed: () {
              Navigator.pushNamed(context, HandmadeAddScreen.routeName);
            },
            child: Icon(Icons.add)),
        body:
            BlocBuilder<HandmadeBloc, HandmadeState>(builder: (context, state) {
          if (state is HandmadeErrorState) {
            _items = [];
            SchedulerBinding.instance?.addPostFrameCallback((_) {
              Fluttertoast.showToast(
                  msg: state.error ?? '',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            });
          }
          if (state is MyHandmadeSuccessState) {
            print('zzzzzzz');
            if (_items == null) {
              _items = [];
            }
            _items!.addAll(state.items!);
          }
          if (state is HandmadeRemoveSuccessState) {
            _items!.removeWhere((element) => element.id == state.model.id);
            SchedulerBinding.instance?.addPostFrameCallback((_) {
              Fluttertoast.showToast(
                  msg: state.message ?? '',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );            });
          }

          return RefreshIndicator(
              onRefresh: () async {
                if (_items != null) {
                  _items!.clear();
                  _items = null;
                }
                if (_user != null) {
                  _handmaneBloc.myPage = 1;
                  _handmaneBloc.add(FetchMyHandmadeEvent(user: _user!));
                }
              },
              child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: _scrollController,
                  slivers: [
                    _items == null
                        ? LoadingSliver()
                        : _items!.length == 0
                            ? CenterWidgetListSliver(
                                label: "My Handmade is empty")
                            : SliverToBoxAdapter(
                                child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    // padding: EdgeInsets.symmetric(vertical: 16),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: _items!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return HandmadeWidget(
                                          model: _items![index],
                                          onDeleteTap: () =>
                                              _deleteItem(_items![index]));
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

  void _deleteItem(HandmadeModel model) {
    _handmaneBloc.add(HandmadeRemoveEvent(user: _user!, model: model));
  }
}
