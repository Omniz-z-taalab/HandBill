import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/services/patented_model.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patented_details_screen.dart';

class PatentedWidget extends StatelessWidget {
  final PatentedModel model;
  final Function? onDeleteTap;
  final bool? isMy;

  PatentedWidget({required this.model, this.onDeleteTap, this.isMy = false});

  final double marginVer = 16, marginBetween = 8;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.25;
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, PatentedDetailsScreen.routeName,
              arguments: RouteArgument(param: model, check: isMy));
        },
        child: Container(

            decoration: BoxDecoration(color: Colors.white),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
            CachedNetworkImage( imageUrl:'${model!.image![0].url!}',width: 200,height: 200,
            ),
              Container(
                  color: Color(0xfffafafa), height: 2, width: double.infinity),
              Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(children: [
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: Text(model.title.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start))),
                    onDeleteTap == null
                        ? SizedBox()
                        : Material(
                            color: Colors.white,
                            child: IconButton(
                                onPressed: () => onDeleteTap!(),
                                icon: Icon(Icons.close,
                                    color: Color(0xffBDBDBD))))
                  ]))
            ])));
  }
}
