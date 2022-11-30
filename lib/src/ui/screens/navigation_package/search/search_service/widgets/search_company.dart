import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/constns.dart';
import '../../../../../../data/model/company.dart';
import '../../../../../../data/model/local/route_argument.dart';
import '../../../../details_package/company/company_screen.dart';

Widget SearchCompany(Company model, context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, CompanyScreen.routeName,
          arguments: RouteArgument(param: model.id));
    },
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Text(
            model.name!,
            style: TextStyle(
              color: Colors.black,
            ),
          )
        ],
      ),
    ),
  );
}
