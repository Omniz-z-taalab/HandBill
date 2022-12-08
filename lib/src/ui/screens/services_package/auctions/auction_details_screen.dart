import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/services/auction_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/expandable_text.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/screens/common/image_full_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/api_data.dart';

class AuctionDetailsScreen extends StatefulWidget {
  static const routeName = "/AuctionDetailsScreen";

  final RouteArgument routeArgument;

  AuctionDetailsScreen({required this.routeArgument});

  @override
  _AuctionDetailsScreenState createState() => _AuctionDetailsScreenState();
}

class _AuctionDetailsScreenState extends State<AuctionDetailsScreen> {
  late AuctionModel _model;

  double _marginVer = 16;

  List<ImageModel> _imageList = [];
  int _imageIndex = 0;
  VideoPlayerController? _videoPlayerController1;
  ChewieController? _chewieController;
  bool _addVideo = false;

  User? _user;

  @override
  void initState() {
    _model = widget.routeArgument.param;
    _imageList.addAll(_model.images!);
    if (_model.video != null && _addVideo == false) {
      initializePlayer(_model.video!.url!);
    }
    _user = BlocProvider.of<GlobalBloc>(context).user;
    if (_user != null) {
      // _users.add(ChatUser(
      //     id: _user!.id,
      //     name: _user!.name,
      //     email: _user!.email,
      //     deviceToken: _user!.deviceToken,
      //     thumb: placeholder));
      // _users.add(ChatUser(
      //     id: _model.company!.id,
      //     name: _model.company!.name,
      //     email: _model.company!.email,
      //     deviceToken: _model.company!.deviceToken,
      //     thumb: _model.company!.logo!.url));
      // _conversation = ConversationModel(users: _users);
    }
    super.initState();
  }

  bool showContact = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: RegularAppBar(label: "AuctionDetails".tr()),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: size.height * 0.4,
                    color: Colors.white,
                    child: PageView.builder(
                        itemCount: _imageList.length,
                        controller: PageController(viewportFraction: 1),
                        onPageChanged: (int index) {
                          setState(() => _imageIndex = index);
                          if (index == 1 && _chewieController != null) {
                            _videoPlayerController1!.pause();
                          }
                        },
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0 && _chewieController != null) {
                            return Chewie(controller: _chewieController!);
                          } else {
                            return InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, ImageFullScreen.routeName,
                                  arguments: RouteArgument(
                                      param: _imageList[index].url)),
                              child: CachedNetworkImage(
                                  imageUrl: _imageList[index].url!,
                                  placeholder: (context, url) => Center(
                                      heightFactor: 1,
                                      widthFactor: 1,
                                      child: CircularProgressIndicator(
                                          color: mainColorLite,
                                          strokeWidth: 2)),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error,
                                          color: mainColorLite)),
                            );
                          }
                        })),
                SizedBox(height: _marginVer),
                _imageList.isEmpty
                    ? SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            DotsIndicator(
                                dotsCount: _imageList.length,
                                position: _imageIndex.toDouble(),
                                decorator: DotsDecorator(
                                    color: Color(0x26000000),
                                    activeColor: Color(0x80000000),
                                    size: const Size.square(4.0),
                                    activeSize: const Size(10.0, 4.0),
                                    activeShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))))
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
                          Container(
                            height: 100,
                            child: Row(children: [
                              AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                _model.company!.logo == null
                                                    ? placeholder
                                                    : "${APIData.domainLink}${_model.company!.logo!.thump}"),
                                            fit: BoxFit.cover),
                                        color: Color(0xffeeeeee),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Color(0xffe0e0e0)))),
                              ),
                              SizedBox(width: 16),
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Seller".tr(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: textDarkColor,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 60.h,
                                      width: 200.w,
                                      child: Text(
                                          _model.company!.name!.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: textDarkColor)),
                                    ),
                                  ]),
                            ]),
                          ),
                          SizedBox(height: _marginVer),
                          _divider(),
                          SizedBox(height: _marginVer),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Phone : ".tr(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: _marginVer),
                                      Text(
                                          _model.company!.firstPhone.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Location : ".tr(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: _marginVer),
                                      Text(
                                          _model.company!.leftDataOfCompanies!
                                              .address
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14))
                                    ]),
                              ]),
                          SizedBox(height: 200)
                        ]))
              ],
            ),
          ),
          Positioned(
            bottom: 70.h,
            right: 30.w,
            child: InkWell(
              onTap: () {
                setState(() {
                  showContact = !showContact;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(12),
                child: Icon(
                  showContact ? Icons.close : Icons.chat,
                  size: 20.w,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (showContact == true) ...[
            Positioned(
              bottom: 350.h,
              right: 20.w,
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                  onPressed: () async {
                    if (_user == null) {
                      Fluttertoast.showToast(msg: "toast.login".tr());
                    } else {
                      if (_model.company!.deviceToken != null) {
                        //?text=${Uri.parse(description)}
                        await canLaunch(
                                "https://wa.me/+2${_model.company!.leftDataOfCompanies!.firstMobile != null && _model.company!.leftDataOfCompanies!.firstMobile != '' ? _model.company!.leftDataOfCompanies!.firstMobile : _model.company!.firstPhone}")
                            ? launch(
                                "https://wa.me/+2${_model.company!.leftDataOfCompanies!.firstMobile != null && _model.company!.leftDataOfCompanies!.firstMobile != '' ? _model.company!.leftDataOfCompanies!.firstMobile : _model.company!.firstPhone}")
                            : print("cannot launch");
                      }
                    }
                  },
                  color: Colors.transparent,
                  icon: Image.asset(
                    "assets/icons/whatsappp.png",
                    height: 100.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 250.h,
              right: 20.w,
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                  onPressed: () async {
                    if (_user == null) {
                      Fluttertoast.showToast(msg: "toast.login".tr());
                    } else {
                      if (_model.company!.deviceToken != null) {
                        await canLaunch(
                                "tel:${_model.company!.leftDataOfCompanies!.firstMobile != null && _model.company!.leftDataOfCompanies!.firstMobile != '' ? _model.company!.leftDataOfCompanies!.firstMobile : _model.company!.firstPhone}")
                            ? launch(
                                "tel:${_model.company!.leftDataOfCompanies!.firstMobile != null && _model.company!.leftDataOfCompanies!.firstMobile != '' ? _model.company!.leftDataOfCompanies!.firstMobile : _model.company!.firstPhone}")
                            : print("cannot launch");
                      }
                    }
                  },
                  color: Colors.white,
                  icon: Icon(
                    Icons.phone,
                    size: 30.w,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 150.h,
              right: 20.w,
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                  onPressed: () async {
                    if (_user == null) {
                      Fluttertoast.showToast(msg: "toast.login".tr());
                    } else {
                      final Uri params = Uri(
                        scheme: 'mailto',
                        path: '${_model.company!.email}',
                        query: 'subject=Hand bill request &body=description',
                      );
                      final url = params.toString();
                      await canLaunch("$url")
                          ? launch("$url")
                          : print("can not open gmail");
                    }
                  },
                  color: Colors.white,
                  icon: Icon(
                    Icons.email,
                    size: 30.w,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> initializePlayer(String url) async {
    _videoPlayerController1 = VideoPlayerController.network(url);
    await _videoPlayerController1!.initialize();
    _createChewieController();
    setState(() {
      _imageList.insert(0, ImageModel());
      _addVideo = true;
    });
  }

  void _createChewieController() {
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1!,
        // autoPlay: true,
        showControlsOnInitialize: false,
        materialProgressColors: ChewieProgressColors(playedColor: Colors.white),
        looping: true,
        showOptions: false);
  }

  Widget _divider() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        width: double.infinity,
        height: 2,
        color: Color(0xffeeeeee));
  }

  @override
  void dispose() {
    _imageList.clear();
    if (_videoPlayerController1 != null) _videoPlayerController1!.dispose();
    if (_chewieController != null) _chewieController!.dispose();
    super.dispose();
  }
}
