import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_bloc.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_event.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_state.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';
import '../../common/services_company_widget/customs_widget.dart';

class CustomsScreen extends StatefulWidget {
  static const routeName = "/CustomsScreen";

  @override
  _CustomsScreenState createState() => _CustomsScreenState();
}

class _CustomsScreenState extends State<CustomsScreen> {
  List<Company>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late OtherCompanyBloc _otherCompanyBloc;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;

  @override
  void initState() {
    _otherCompanyBloc = BlocProvider.of<OtherCompanyBloc>(context);
    _otherCompanyBloc.customsPage = 1;
    _otherCompanyBloc.add(FetchCustomsCompaniesEvent());
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

    if (offset + offsetVisibleThreshold >= max &&
        !_otherCompanyBloc.isFetching) {
      setState(() {
        _otherCompanyBloc.isFetching = true;
      });
      _otherCompanyBloc.add(FetchCustomsCompaniesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: RegularAppBar(label: "Customs"),
        // backgroundColor: Color(0xfff5f5f5),
        body: RefreshIndicator(
            onRefresh: () async {
              if (_items != null) {
                _items!.clear();
                _items = null;
              }

              _otherCompanyBloc.customsPage = 1;
              _otherCompanyBloc.add(FetchCustomsCompaniesEvent());
            },
            child: BlocListener<OtherCompanyBloc, OtherCompanyState>(
                listener: (context, state) {
                  if (state is OtherCompanyErrorState) {
                    _items = [];
                    SchedulerBinding.instance?.addPostFrameCallback((_) {
                      displaySnackBar(
                          title: state.error!, scaffoldKey: _scaffoldKey);
                    });
                  }
                  if (state is CustomsCompaniesSuccessState) {
                    setState(() {
                      if (_items == null) {
                        _items = [];
                      }
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
                                  label: "Customs is empty")
                              : SliverToBoxAdapter(
                                  child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      // padding: EdgeInsets.symmetric(vertical: 16),
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: _items!.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return CustomsWidget(
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
