import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/home/banner.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/screens/common/services_company/services_company_details_screen.dart';
import 'package:hand_bill/src/ui/screens/details_package/company/company_screen.dart';

class SliderWidget extends StatelessWidget {
  final BannerModel model;

  SliderWidget({required this.model});

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
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Color(0xfff5f5f5), width: 1.5),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xfff5f5f5),
                      blurRadius: 3,
                      spreadRadius: 3)
                ]),
            child: CachedNetworkImage(

                imageUrl: model.image!,
                fit: BoxFit.cover,
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
