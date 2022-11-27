import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/chats/conversition_model.dart';
import 'package:hand_bill/src/data/model/local/chat_user.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/services/offer_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/expandable_text.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/screens/common/image_full_screen.dart';

class OfferDetailsScreen extends StatefulWidget {
  static const routeName = "/OfferDetailsScreen";
  late final RouteArgument routeArgument;

  OfferDetailsScreen({required this.routeArgument});

  @override
  _OfferDetailsScreenState createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  late OfferModel _model;
  double _marginVer = 16;
  double? _save;

  User? _user;
  ConversationModel? _conversation;
  List<ChatUser> _users = [];

  int _imageIndex = 0;

  @override
  void initState() {
    _model = widget.routeArgument.param;
    _save = (_model.oldPrice)! - (_model.newPrice)!;
    _user = BlocProvider.of<GlobalBloc>(context).user;

    _user = BlocProvider.of<GlobalBloc>(context).user;
    if (_user != null) {
      _users.add(ChatUser(
          id: _user!.id,
          name: _user!.name,
          email: _user!.email,
          deviceToken: _user!.deviceToken,
          thumb: placeholder));
      _users.add(ChatUser(
          id: _model.company!.id,
          name: _model.company!.name,
          email: _model.company!.email,
          deviceToken: _model.company!.deviceToken,
          thumb: _model.company!.logo!.url));
      _conversation = ConversationModel(users: _users);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: RegularAppBar(label: "Offer_Details".tr()),
        floatingActionButton: FloatingActionButton(
            backgroundColor: mainColorLite,
            onPressed: () {
              if (_user == null) {
                Fluttertoast.showToast(msg: "login".tr());
              } else {
                // Navigator.pushNamed(context, InboxScreen.routeName,
                //     arguments: RouteArgument(param: _conversation));
              }
            },
            child: Icon(Icons.chat_outlined)),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Container(
                        height: size.height * 0.3,
                        // color: Colors.white,
                        child: PageView.builder(
                            itemCount: _model.images!.isEmpty
                                ? 1
                                : _model.images!.length,
                            controller: PageController(viewportFraction: 1),
                            onPageChanged: (int index) {
                              setState(() => _imageIndex = index);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, ImageFullScreen.routeName,
                                      arguments: RouteArgument(
                                          param: _model.images![index].url)),
                                  child: CachedNetworkImage(
                                      // fit: BoxFit.cover,
                                      imageUrl: _model.images!.isEmpty
                                          ? placeholder
                                          : _model.images![index].thump!,
                                      placeholder: (context, url) => FittedBox(
                                          child: Transform.scale(
                                              scale: 0.2,
                                              child: CircularProgressIndicator(
                                                  color: mainColorLite,
                                                  strokeWidth: 2))),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error,
                                              color: mainColorLite)));
                            })),
                    Positioned(
                        bottom: 8,
                        right: 0,
                        left: 0,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DotsIndicator(
                                  dotsCount: _model.images!.isEmpty
                                      ? 1
                                      : _model.images!.length,
                                  position: _imageIndex.toDouble(),
                                  decorator: DotsDecorator(
                                      color: Color(0x4DFFFFFF),
                                      activeColor: Color(0xB3FFFFFF),
                                      size: const Size.square(4.0),
                                      activeSize: const Size(10.0, 4.0),
                                      activeShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))))
                            ])),
                  ]),
                  SizedBox(height: _marginVer),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: _marginVer * 0.5),
                            Text(_model.title ?? "",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17)),
                            SizedBox(height: _marginVer),
                            ExpandableTextWidget(text: _model.description!),
                            _divider(),
                            InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //     context, CompanyScreen.routeName,
                                  //     arguments:
                                  //         RouteArgument(param: Market()));
                                },
                                child: SizedBox(
                                    height: 60,
                                    child: Row(children: [
                                      AspectRatio(
                                          aspectRatio: 1 / 1,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              _model
                                                                      .company!
                                                                      .logo!
                                                                      .url ??
                                                                  placeholder),
                                                      fit: BoxFit.cover),
                                                  color: Color(0xffeeeeee),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          Color(0xffe0e0e0))))),
                                      SizedBox(width: 16),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Seller".tr(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: textDarkColor,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text(_model.company!.name!,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: textDarkColor)),
                                          ]),
                                    ]))),
                            // SizedBox(height: _marginVer),
                            _divider(),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Text("Price : ".tr(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: Color(0xffDD2C00),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                          TextSpan(
                                              text: _model.oldPrice.toString(),
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                          TextSpan(text: " \$")
                                        ]))
                                  ]),
                                  SizedBox(width: 8),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("new price : ".tr(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        Text("${_model.newPrice} \$",
                                            style: TextStyle(
                                                color: textDarkColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                ]),
                            SizedBox(height: _marginVer),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("You Save : ".tr(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        Text("$_save \$",
                                            style: TextStyle(
                                                color: Color(0xff4CAF50),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                  SizedBox(width: 8),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Location : ".tr(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        Text(_model.company!.country,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14))
                                      ])
                                ]),
                            SizedBox(height: 200)
                          ]))
                ])));
  }

  Widget _divider() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        width: double.infinity,
        height: 2,
        color: Color(0xffeeeeee));
  }
}
