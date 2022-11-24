import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/offer/offers_bloc.dart';
import 'package:hand_bill/src/blocs/offer/offers_event.dart';
import 'package:hand_bill/src/blocs/offer/offers_state.dart';
import 'package:hand_bill/src/data/model/services/offer_model.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';

import 'component/offers_widget.dart';

class OffersScreen extends StatefulWidget {
  static const routeName = "/OffersScreen";

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  List<OfferModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late OffersBloc _offersBloc;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;

  @override
  void initState() {
    _offersBloc = BlocProvider.of<OffersBloc>(context);
    _offersBloc.add(FetchOffersEvent());
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

    if (offset + offsetVisibleThreshold >= max && !_offersBloc.isFetching) {
      setState(() {
        _offersBloc.isFetching = true;
      });
      _offersBloc.add(FetchOffersEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: RegularAppBar(label: "offers".tr()),
        backgroundColor: Color(0xffeeeeee),
        body: RefreshIndicator(onRefresh: () async {
          if (_items != null) {
            // _items!.clear();
            // _items = null;
          }

          _offersBloc.page = 1;
          _offersBloc.add(FetchOffersEvent());
        }, child:
            BlocBuilder<OffersBloc, OffersState>(builder: (context, state) {
          if (state is OffersErrorState) {
            _items = [];
            SchedulerBinding.instance?.addPostFrameCallback((_) {
              displaySnackBar(title: state.error!, scaffoldKey: _scaffoldKey);
            });
          }
          if (state is OffersSuccessState) {
            if (_items == null) {
              _items = [];
            }
            _items!.addAll(state.items!);
          }

          return CustomScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                _items == null
                    ? LoadingSliver()
                    : _items!.length == 0
                        ? CenterWidgetListSliver(label: "Offers_is_empty".tr())
                        : SliverToBoxAdapter(
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                // padding: EdgeInsets.symmetric(vertical: 16),
                                primary: false,
                                shrinkWrap: true,
                                itemCount: _items!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return OfferWidget(model: _items![index]);
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
              ]);
        })));
  }
}
