import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/help/help_bloc.dart';
import 'package:hand_bill/src/blocs/help/help_event.dart';
import 'package:hand_bill/src/blocs/help/help_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/account_package/agent_model.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';

import 'package:url_launcher/url_launcher.dart';

import 'component/agent_widget.dart';

class AgentsScreen extends StatefulWidget {
  static const routeName = "/AgentsScreen";

  @override
  _AgentsScreenState createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  List<AgentModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late HelpBloc _helpBloc;

  bool loading = false;

  @override
  void initState() {
    _helpBloc = BlocProvider.of<HelpBloc>(context);
    _helpBloc.add(FetchAgentEvent());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RegularAppBar(label: "Our_Agents".tr()),
        body: RefreshIndicator(
            onRefresh: () async {
              if (_items != null) {
                // _items!.clear();
                // _items = null;
              }
              _helpBloc.add(FetchAgentEvent());
            },
            child: BlocListener<HelpBloc, HelpState>(
                listener: (context, state) {
                  if (state is HelpErrorState) {
                    _items = [];
                    SchedulerBinding.instance?.addPostFrameCallback((_) {
                      displaySnackBar(
                          title: state.error!, scaffoldKey: _scaffoldKey);
                    });
                  }
                  if (state is AgentSuccessState) {
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
                    slivers: [
                      _items == null
                          ? LoadingSliver()
                          : _items!.length == 0
                              ? CenterWidgetListSliver(label: "Agents is empty")
                              : SliverToBoxAdapter(
                                  child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      // padding: EdgeInsets.symmetric(vertical: 16),
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: _items!.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return AgentWidget(
                                            model: _items![index],
                                            onTap: () => launchEmailSubmission(
                                                _items![index].email!));
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              Container(
                                                  height: 6,
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

  void launchEmailSubmission(String email) async {
    final Uri params = Uri(scheme: 'mailto', path: email, queryParameters: {
      // 'subject': 'Default Subject',
      // 'body': 'Default body'
    });
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
