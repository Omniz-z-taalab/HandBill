import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/banner/sub_product.dart';

import '../../../../../common/constns.dart';
import '../../../../../data/model/local/route_argument.dart';
import '../../../details_package/company/company_screen.dart';

class SliderSubWidget extends StatelessWidget {
  final DataPro model;

  SliderSubWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {

          Navigator.pushNamed(context, CompanyScreen.routeName,
              arguments: RouteArgument(param: model.company!.id));

        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
                // height: 20,
                imageUrl: '${APIData.domainLink}${model.image}',
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(
                    heightFactor: 3,
                    widthFactor: 2,
                    child: CircularProgressIndicator(
                        color: mainColorLite, strokeWidth: 1)),
                errorWidget: (context, url, error) =>
                new Icon(Icons.error, color: mainColorLite)),
          ),
        ));
  }
}
