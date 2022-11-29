import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/help/help_bloc.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/helpcenterMode/help-model.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../blocs/help/help_event.dart';
import '../../../../blocs/help/help_state.dart';
import '../../../component/custom/login_first_widget_sliver.dart';
import '../../services_package/patented/patents_screen.dart';
import 'component/helpCenter_widget.dart';

class HelpCenterScreen extends StatefulWidget {
  static const routeName = "/HelpCenterScreen";

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  late HelpBloc helpBloc;
  List<HelpCenterModel>? mails;

  @override
  void initState() {
    helpBloc = BlocProvider.of<HelpBloc>(context);
    helpBloc.add(HelpCenterEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RegularAppBar(label: "Help Center"),
        body: BlocConsumer<HelpBloc, HelpState>(
          listener: (context, state) {
            if (state is HelpCenterSuccess) {
              mails = [];
              // mails = state.items;
              mails!.addAll(state.items!);
            }
          },
          builder: (context, state) {
            return CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
              mails == null
                  ? LoadingSliver()
                  : mails!.length == 0
                      ? CenterWidgetListSliver(label: "search is empty")
                      : SliverToBoxAdapter(
                          // physics: BouncingScrollPhysics(),
                          child: SizedBox(
                            height: 500,
                            child: ListView.separated(
                                itemBuilder: (context, index) =>
                                    HelpCenter(mails![index]),
                                separatorBuilder:
                                    (BuildContext context, int index) => SizedBox(
                                          height: 10,
                                        ),
                                itemCount: mails!.length),
                          ),
                        )
            ]);
          },
        ));
  }
}

