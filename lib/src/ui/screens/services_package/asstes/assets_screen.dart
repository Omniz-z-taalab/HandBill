import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/assets/assets_bloc.dart';
import 'package:hand_bill/src/blocs/assets/assets_event.dart';
import 'package:hand_bill/src/blocs/assets/assets_state.dart';
import 'package:hand_bill/src/data/model/services/assets_model.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';

import 'component/assets_widget.dart';

class AssetsScreen extends StatefulWidget {
  static const routeName = "/AssetsScreen";

  @override
  _AssetsScreenState createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  List<AssetsModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AssetsBloc _assetsBloc;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;

  @override
  void initState() {
    _assetsBloc = BlocProvider.of<AssetsBloc>(context);
    _assetsBloc.page = 1;
    _assetsBloc.add(FetchAssetsEvent());
    _scrollController = ScrollController()..addListener(_onScroll);

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

    if (offset + offsetVisibleThreshold >= max && !_assetsBloc.isFetching) {
      setState(() {
        _assetsBloc.isFetching = true;
      });
      _assetsBloc.add(FetchAssetsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: RegularAppBar(label: "assets".tr()),
        backgroundColor: Color(0xffeeeeee),
        body: RefreshIndicator(
            onRefresh: () async {
              if (_items != null) {
                _items!.clear();
                _items = null;
              }

              _assetsBloc.page = 1;
              _assetsBloc.add(FetchAssetsEvent());
            },
            child: BlocConsumer<AssetsBloc, AssetsState>(
              listener: (context, state) {
                if (state is AssetsErrorState) {
                  _items = [];
                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    displaySnackBar(
                        title: state.error!, scaffoldKey: _scaffoldKey);
                  });
                }
                if (state is AssetsSuccessState) {
                  if (_items == null) {
                    _items = state.items;
                  }
                }
              },
              builder: (context, state) {
                return CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      _items == null
                          ? LoadingSliver()
                          : _items!.length == 0
                              ? CenterWidgetListSliver(label: "assets_is_empty".tr())
                              : SliverToBoxAdapter(
                                  child: SizedBox(
                                  height: 700,
                                  child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      // padding: EdgeInsets.symmetric(vertical: 16),
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: _items!.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return AssetsWidget(
                                            model: _items![index]);
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              Container(
                                                  height: 10,
                                                  color: Color(0xffeeeeee))),
                                )),
                      SliverToBoxAdapter(child: SizedBox(height: 100)),
                      SliverToBoxAdapter(
                          child: Container(
                              child: loading == true
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 40),
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2)))
                                  : SizedBox()))
                    ]);
              },
            )));
  }
}
