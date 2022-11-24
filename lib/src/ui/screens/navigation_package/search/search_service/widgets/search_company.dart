import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/constns.dart';
import '../../../../../../data/model/company.dart';
import '../../../../../../data/model/local/route_argument.dart';
import '../../../../details_package/company/company_screen.dart';

Widget SearchCompany(Company model ,context) {
  return InkWell(
    onTap: (){
      Navigator.pushNamed(context, CompanyScreen.routeName,
          arguments: RouteArgument(param: model.id));
    },
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          // CircleAvatar(
          //     backgroundColor: Colors.grey,
          //     child:  CachedNetworkImage(
          //         width: 370,
          //         // height: 200,
          //         imageUrl:
          //         model!.logo!.icon! != null
          //         ?model!.logo!.icon!
          //             :placeholder,
          //         placeholder: (context, url) => Center(
          //             heightFactor: 1,
          //             widthFactor: 1,
          //             child: CircularProgressIndicator(
          //                 color: mainColorLite,
          //                 strokeWidth: 1)),
          //         errorWidget: (context, url, error) =>
          //         new Icon(Icons.error,
          //             color: mainColorLite))),

          SizedBox(
            width: 10,
          ),
          //      child:  CachedNetworkImage(
          // width: 370,
          //     // height: 200,
          //     imageUrl: model!.image!,
          //     placeholder: (context, url) => Center(
          //         heightFactor: 1,
          //         widthFactor: 1,
          //         child: CircularProgressIndicator(
          //             color: mainColorLite,
          //             strokeWidth: 1)),
          //     errorWidget: (context, url, error) =>
          //     new Icon(Icons.error,
          //         color: mainColorLite))),
          Text(
            model.name!,
            style: TextStyle(color: Colors.black,),
          )
        ],
      ),
    ),
  );
}
