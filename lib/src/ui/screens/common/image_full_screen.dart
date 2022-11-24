import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/helper/helpers.dart';

class ImageFullScreen extends StatefulWidget {
  static const routeName = "/imageFullScreen";

  final RouteArgument? routeArgument;

  ImageFullScreen({required this.routeArgument});

  @override
  _ImageFullScreenState createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  String? imagePath;
  bool isDragging = false;

  @override
  void initState() {
    imagePath = widget.routeArgument!.param ?? placeholder;
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Helper.chaneStatusBarColor(
          statusBarColor: Colors.black, brightness: Brightness.light);
    });
    super.initState();
  }

  _out(BuildContext _context) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Helper.chaneStatusBarColor(
          statusBarColor: Theme.of(_context).backgroundColor,
          brightness: Theme.of(_context).brightness);
    });
  }

  @override
  void dispose() {
    Helper.chaneStatusBarColor(
        statusBarColor: Colors.white, brightness: Brightness.dark);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Positioned(
              width: MediaQuery.of(context).size.width,
              top: 0,
              bottom: 0,
              child: InteractiveViewer(
                  // panEnabled: false,
                  // Set it to false to prevent panning.
                  // boundaryMargin: EdgeInsets.all(80),
                  minScale: 0.5,
                  maxScale: 4,
                  child: CachedNetworkImage(
                      imageUrl: imagePath ?? placeholder,
                      placeholder: (context, url) => Center(
                          heightFactor: 1,
                          widthFactor: 1,
                          child: CircularProgressIndicator(
                              color: mainColorLite, strokeWidth: 2)),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error, color: Colors.white)))),
          Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0x1a000000),
                          borderRadius: BorderRadius.circular(900),
                          border: Border.all(color: Color(0x26FFFFFF))),
                      child:
                          Icon(Icons.arrow_back_rounded, color: Colors.white))))
        ]));
  }
}
