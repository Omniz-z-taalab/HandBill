import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../common/api_data.dart';
import '../../../../../common/constns.dart';
import '../../../../../data/model/local/route_argument.dart';
import '../../../../../data/response/banner/banner_service_response.dart';
import '../../../details_package/company/company_screen.dart';

class BannerWidget extends StatelessWidget {
  late final BannerServiceModel? model;

  BannerWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {

          Navigator.pushNamed(context, CompanyScreen.routeName,
              arguments: RouteArgument(param: model!.id));

        },
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
             width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(

                imageUrl:'${APIData.domainLink}${model!.image}',
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                    heightFactor: 3,
                    widthFactor: 2,
                    child: CircularProgressIndicator(
                        color: mainColorLite, strokeWidth: 1)),
                // errorWidget: (context, url, error) =>
                // new Icon(Icons.error, color: mainColorLite)),
              ),
            )));
  }
}
