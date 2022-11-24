import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/notification/notifications_bloc.dart';
import 'package:hand_bill/src/blocs/notification/notifications_event.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/notification_model.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/ui/component/custom/swipe_widget.dart';
import 'package:hand_bill/src/ui/screens/details_package/product_details/product_details_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationWidget extends StatefulWidget {
  final NotificationModel model;

  NotificationWidget({required this.model});

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Product _product = Product(
              id: widget.model.id,
              subSubCategoryId: widget.model.subSubCategoryId);
          Navigator.pushNamed(context, ProductDetailsScreen.routeName,
              arguments: RouteArgument(param: _product));
        },
        child: Container(
            color: Theme.of(context).backgroundColor,
            // color: Colors.blue.shade50,
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(widget.model.title.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text(widget.model.body.toString(),
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15)),
                        SizedBox(height: 6),
                        Text(timeago.format(widget.model.dateTime!),
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15)),
                      ])),
              Container(
                  height: 1, width: double.infinity, color: Color(0xffe0e0e0))
            ])));
  }
}
