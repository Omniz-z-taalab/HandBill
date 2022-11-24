import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/LeftDetailsOfCompany.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/data_variable.dart';
import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/component/custom/expandable_text.dart';
import 'package:hand_bill/src/ui/screens/common/image_full_screen.dart';
import 'package:hand_bill/src/ui/screens/details_package/company/component/company_profile.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class ServicesCompanyBoard extends StatefulWidget {
  Company company;

  ServicesCompanyBoard({required this.company});

  @override
  _ServicesCompanyBoardState createState() => _ServicesCompanyBoardState();
}

class _ServicesCompanyBoardState extends State<ServicesCompanyBoard> {
  int _imageIndex = 0;
  List<ImageModel> _images = [];

  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;

  Company? _company;

  String _address = "", _phone = "", _services = "", _name = "";

  LeftDataOfCompanies? _dataOfCompanies;
  List<DataVariable> _dataList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getData();
    super.didChangeDependencies();
  }

  void getData() {
    _company = widget.company;

    if (_company != null) {
      _images.addAll(_company!.images!);
      _name = _company!.name!;
      _address = _company!.leftDataOfCompanies!.address!;
      _phone = _company!.firstPhone ?? "";
      _services = _company!.leftDataOfCompanies!.services!;
      _name = _company!.name!;

      _dataOfCompanies = _company!.leftDataOfCompanies!;

      if (_dataOfCompanies != null) {
        if (_dataList.length > 0) {
          _dataList.clear();
          _dataOfCompanies!.toJson().forEach((key, value) {
            if (value != null) {
              _dataList.add(DataVariable(
                  key: toBeginningOfSentenceCase(key.replaceAll("_", " ")),
                  value: value.toString()));
            }
          });
        } else {
          _dataOfCompanies!.toJson().forEach((key, value) {
            if (value != null && key != "services") {
              _dataList.add(DataVariable(
                  key: key.replaceAll("_", " "), value: value.toString()));
            }
          });
        }
      }
      if (_company!.video != null) {
        initializePlayer(_company!.video!.url!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(children: [
        Stack(children: [
          Container(
              height: size.height * 0.25,
              color: Colors.white,
              child: PageView.builder(
                  itemCount: _images.length,
                  controller: PageController(viewportFraction: 1),
                  onPageChanged: (int index) {
                    setState(() => _imageIndex = index);
                    if (index == 1 && _chewieController != null) {
                      _videoPlayerController1.pause();
                    }
                  },
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0 && _chewieController != null) {
                      return Container(
                          color: Color(0xff000000),
                          child: Chewie(controller: _chewieController!));
                    } else {
                      return InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, ImageFullScreen.routeName,
                              arguments:
                                  RouteArgument(param: _images[index].url)),
                          child: CachedNetworkImage(
                              imageUrl: _images[index].url!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                  heightFactor: 1,
                                  widthFactor: 1,
                                  child: CircularProgressIndicator(
                                      color: mainColorLite, strokeWidth: 2)),
                              errorWidget: (context, url, error) =>
                                  new Image.asset(
                                    "assets/images/hb_logo.jpeg",
                                    fit: BoxFit.contain,
                                  )));
                    }
                  })),
          Positioned(
              bottom: 16,
              left: 16,
              child: InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, ImageFullScreen.routeName,
                      arguments: RouteArgument(param: _company!.logo!.url)),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: size.width * 0.18,
                    width: size.width * 0.18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xffffffff)),
                    child: CachedNetworkImage(
                        imageUrl: _company!.logo!.url!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Transform.scale(
                            scale: 0.4,
                            child: CircularProgressIndicator(
                                color: mainColorLite, strokeWidth: 2)),
                        errorWidget: (context, url, error) => new Image.asset(
                              "assets/images/hb_logo.jpeg",
                              fit: BoxFit.contain,
                            )),
                  ))),
          _images.isEmpty
              ? SizedBox()
              : Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: DotsIndicator(
                      dotsCount: _images.length,
                      position: _imageIndex.toDouble(),
                      decorator: DotsDecorator(
                          color: Color(0x66ffffff),
                          activeColor: Color(0xffffffff),
                          size: const Size(6.0, 4.0),
                          activeSize: const Size(12.0, 4.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)))))
        ]),
      ]),
      // _divider(),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 16),
            Text(_name,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: 2,
                color: Color(0xffeeeeee)),
            Text("Contact information",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 16),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xffe0e0e0))),
                child: Column(children: [
                  Row(children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 12),
                    Expanded(
                        child: Text(_address,
                            style:
                                TextStyle(fontSize: 15, color: textLiteColor)))
                  ]),
                  SizedBox(height: 16),
                  Row(children: [
                    Icon(Icons.phone_android),
                    SizedBox(width: 12),
                    Expanded(
                        child: Text(_phone,
                            style:
                                TextStyle(fontSize: 15, color: textLiteColor)))
                  ]),
                ]))
          ])),
      SizedBox(height: 24),

      // _divider(),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Services",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 16),
            ExpandableTextWidget(text: _services)
          ])),

      _divider(),
      ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: _dataList.length,
        itemBuilder: (BuildContext context, int index) =>
            _dataList[index].key!.trim() != "commercial register" &&
                    _dataList[index].key!.trim() != "tax card"
                ? DataRowWidget(model: _dataList[index])
                : SizedBox(),
      ),
      SizedBox(height: 100),
    ]);
  }

  Widget _divider() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        width: double.infinity,
        height: 2,
        color: Color(0xffeeeeee));
  }

  Future<void> initializePlayer(String url) async {
    _videoPlayerController1 = VideoPlayerController.network(url);
    await _videoPlayerController1.initialize();
    _createChewieController();
    setState(() {
      _images.insert(0, ImageModel());
    });
  }

  void _createChewieController() {
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        // autoPlay: true,
        showControlsOnInitialize: false,
        materialProgressColors: ChewieProgressColors(playedColor: Colors.white),
        looping: true,
        showOptions: false);
  }

  @override
  void dispose() {
    try {
      if (_chewieController != null) _chewieController!.dispose();
      if (_videoPlayerController1 != null) _videoPlayerController1.dispose();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }
}
