import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/auction/aucations_bloc.dart';
import 'package:hand_bill/src/blocs/auction/aucations_event.dart';
import 'package:hand_bill/src/blocs/auction/aucations_state.dart';
import 'package:hand_bill/src/data/model/services/auction_model.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';

import 'component/auctions_widget.dart';

class AuctionsScreen extends StatefulWidget {
  static const routeName = "/AuctionsScreen";

  @override
  _AuctionsScreenState createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> {
  List<AuctionModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AuctionsBloc _auctionBloc;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;

  @override
  void initState() {
    _auctionBloc = BlocProvider.of<AuctionsBloc>(context);
    _auctionBloc.page = 1;
    _auctionBloc.add(FetchAuctionsEvent());
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

    if (offset + offsetVisibleThreshold >= max && !_auctionBloc.isFetching) {
      setState(() {
        _auctionBloc.isFetching = true;
      });
      _auctionBloc.add(FetchAuctionsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RegularAppBar(label: "auctions".tr()),
        backgroundColor: Color(0xffeeeeee),
        body: RefreshIndicator(
            onRefresh: () async {
              if (_items != null) {
                _items!.clear();
                _items = null;
              }

              _auctionBloc.page = 1;
              _auctionBloc.add(FetchAuctionsEvent());
            },
            child: BlocListener<AuctionsBloc, AuctionsState>(
                listener: (context, state) {
                  if (state is AuctionsErrorState) {
                    setState(() {
                    _items = [];
                    });

                    displaySnackBar(
                        title: state.error!, scaffoldKey: _scaffoldKey);
                  }
                  if (state is AuctionsSuccessState) {
                    if (_items == null) {
                      _items = [];
                    }
                    setState(() {
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
                                  label: "Auction_is_empty".tr())
                              : SliverToBoxAdapter(
                                  child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      // padding: EdgeInsets.symmetric(vertical: 16),
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: _items!.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return AuctionWidget(
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
                              child: loading == true
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
