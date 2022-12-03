import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_bill/src/blocs/hand_made/hand_made_bloc.dart';
import 'package:hand_bill/src/blocs/hand_made/hand_made_event.dart';
import 'package:hand_bill/src/blocs/hand_made/hand_made_state.dart';
import 'package:hand_bill/src/data/model/services/handmade_model.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/hand_made/my_handmade_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';

import 'component/hand_made_widget.dart';

class HandmadeScreen extends StatefulWidget {
  static const routeName = "/HandmadeScreen";

  @override
  _HandmadeScreenState createState() => _HandmadeScreenState();
}

class _HandmadeScreenState extends State<HandmadeScreen> {
  List<HandmadeModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late HandmadeBloc _handmadeBloc;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool _loading = false;

  @override
  void initState() {
    _handmadeBloc = BlocProvider.of<HandmadeBloc>(context);
    _handmadeBloc.allPage = 1;
    _handmadeBloc.add(FetchHandmadeEvent());
    _scrollController = ScrollController()..addListener(_onScroll);

    super.initState();
  }

  @override
  void didUpdateWidget(HandmadeScreen oldWidget) {
    // init();
    super.didUpdateWidget(oldWidget);
  }

  init() {
    _handmadeBloc.add(FetchHandmadeEvent());
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
    final max = _scrollController!.position.maxScrollExtent;
    final offset = _scrollController!.offset;

    if (offset + offsetVisibleThreshold >= max && !_handmadeBloc.isFetching) {
      setState(() {
        _loading = true;
      });
      _handmadeBloc.add(FetchHandmadeEvent());
    }
  }

  double iconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: RegularAppBar(
            label: "hand_made".tr(),
            widget: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MyHandmadeScreen.routeName);
                },
                child: Icon(Icons.add))),
        backgroundColor: Color(0xffeeeeee),
        body: RefreshIndicator(
            onRefresh: () async {
              if (_items != null) {
                _items!.clear();
                _items = null;
              }
              _handmadeBloc.allPage = 1;
              _handmadeBloc.add(FetchHandmadeEvent());
            },
            child: BlocListener<HandmadeBloc, HandmadeState>(
                listener: (context, state) {
                  if (state is HandmadeErrorState) {
                    _items = [];
                    _loading = false;
                    displaySnackBar(
                        title: state.error!, scaffoldKey: _scaffoldKey);
                  }
                  if (state is HandmadeSuccessState) {
                    if (_items == null) {
                      _items = [];
                    }
                    setState(() {
                      _loading = false;
                      _items!.addAll(state.items!);
                    });
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
                                  label: "Handmade is empty")
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
                                            model: _items![index]);
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              Container(
                                                  height: 10,
                                                  color: Color(0xffeeeeee)))),
                      SliverToBoxAdapter(child: SizedBox(height: 100)),
                      SliverToBoxAdapter(
                          child: Container(
                              child: _loading == true
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 40),
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2)))
                                  : SizedBox()))
                    ]))));
  }
}
