import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/api_data.dart';

import '../../../../../../common/constns.dart';
import '../../../../../../data/model/local/route_argument.dart';
import '../../../../../../data/model/serviceCategories_model.dart';
import '../../../../details_package/company/company_screen.dart';
import '../../../../services_package/shipping/Service_first_company.dart';
import '../shipping_screen.dart';
import '../company_service_screen.dart';

Widget ServiceCompany(ServiceModel model,context) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0,left: 10),
    child: InkWell(onTap: () {
      Navigator.pushNamed(context, ShippingScreen.routeName,
          arguments: RouteArgument(param: model));
      print(model.id);

    }, child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              clipBehavior: Clip.antiAlias,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color(0xffeeeeee), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xfff5f5f5), blurRadius: 3, spreadRadius: 3)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                        Container(child: model.image == null
                ? Container(
                // height: 50,
                // width: 50,
                child: Image.asset(
                "assets/images/hb_logo.jpeg",
                  height: 60,
                  // width: 20,
                ),
              )
                  : Image.network(
          model.image![0].url.toString(),
          height: 40,
          )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        model.name,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,color: Colors.black26,)
                  ],
                ),
              ));
        })),
  );
}
