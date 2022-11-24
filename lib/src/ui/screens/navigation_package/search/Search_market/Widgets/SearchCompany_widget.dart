
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/model/local/route_argument.dart';
import '../../../../../../data/response/search/search_product_response.dart';
import '../../../../details_package/company/company_screen.dart';
import '../CompanySearchScreen.dart';

Widget SearchCompanyData(DataCompanySearch model,context) {
  return InkWell(
    onTap: () {
      print(model.id);
      Navigator.pushNamed(context, CompanyScreen.routeName,
          arguments: RouteArgument(param: model.id));
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
      child: Container(
          height: 60,
          width: 200,
          child: Row(
            children: [
              // CachedNetworkImage(imageUrl: model.flag),
              // Padding(
              //     padding: EdgeInsets.all(10),
              //     child: Container(
              //         child: CachedNetworkImage(
              //             imageUrl: model.company!.images![0].thump!))),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  model.name!,
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
            ],
          )),
    ),
  );
}
