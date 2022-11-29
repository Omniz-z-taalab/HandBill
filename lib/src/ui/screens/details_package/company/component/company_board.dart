import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/screens/common/image_full_screen.dart';
import 'package:hand_bill/src/ui/screens/details_package/company/component/company_products.dart';
import 'package:hand_bill/src/ui/screens/details_package/company/component/company_profile.dart';
import 'package:video_player/video_player.dart';

class CompanyBoard extends StatefulWidget {
  Company model;
  List<Product> featuredList = [], products = [];
  List<CategoryModel> categories = [];

  User? user;

  CompanyBoard(
      {required this.model,
      required this.featuredList,
      required this.categories,
      required this.products,
      this.user});

  @override
  _CompanyBoardState createState() => _CompanyBoardState();
}

class _CompanyBoardState extends State<CompanyBoard>
    with TickerProviderStateMixin {
  bool? closed = true, showAll = false;

  int length = 80;

  double radius = 12, marginHorizontail = 16, marginTop = 16, heartSize = 42;

  String? name, description, information, address, phone, mobile, image, rate;

  Company? _company;
  late TabController _tabController;
  int _imageIndex = 0;
  List<ImageModel> _images = [];
  VideoPlayerController? _videoPlayerController1;
  ChewieController? _chewieController;
  bool _addVideo = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _getData();
    super.initState();
    print('dsdsdsdsdsddds');
  }

  Future<void> initializePlayer(String url) async {
    _videoPlayerController1 = VideoPlayerController.network(url);
    await _videoPlayerController1!.initialize();
    _createChewieController();
    _images.insert(0, ImageModel());
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

  @override
  void dispose() {
    if (_videoPlayerController1 != null) _videoPlayerController1!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CompanyBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  _getData() async {
    _company = Company();
    _company = widget.model;
    print(_company!.name!);
    print('ddddddddddddddddddd');
    if (_company != null) {
      name = _company!.name;
      _images = widget.model.images ?? [];

      if (_company!.logo != null) {
        image = _company!.logo!.thump;
      }
      if (_company!.images != null && _addVideo == false) {
        initializePlayer(_company!.video!.url! == null
            ? 'Vedio is empty'
            : _company!.video!.url!);
        _addVideo = true;
      }
    }
  }

  Color textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    // Helper.chaneStatusBarColor(
    //     statusBarColor: Colors.transparent, brightness: Brightness.light);
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
      SliverToBoxAdapter(
          child: Column(children: [
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
                      _videoPlayerController1!.pause();
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
                                      "assets/images/loading.gif")));
                    }
                  })),
          Positioned(
              bottom: 16,
              left: 16,
              child: InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, ImageFullScreen.routeName,
                      arguments: RouteArgument(param: image)),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: size.width * 0.18,
                    width: size.width * 0.18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xffffffff)),
                    child: CachedNetworkImage(
                        imageUrl: image == null ? placeholderLogo : image!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Transform.scale(
                            scale: 0.4,
                            child: CircularProgressIndicator(
                                color: mainColorLite, strokeWidth: 2)),
                        errorWidget: (context, url, error) =>
                            new Image.asset("assets/images/loading.gif")),
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
      ])),
      SliverFillRemaining(
          child: Column(children: <Widget>[
        Container(
            color: Color(0xffffffff),
            child: TabBar(
                controller: _tabController,
                indicatorColor: mainColorLite,
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
                unselectedLabelColor: Colors.grey,
                labelColor: mainColorLite,
                tabs: <Widget>[Tab(text: "Products"), Tab(text: "Profile")])),
        SizedBox(height: 16),
        Expanded(
            child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: <Widget>[
              CompanyProducts(
                  featuredList: widget.featuredList,
                  categories: widget.categories,
                  products: widget.products),
              // CompanyProfile(
              //   leftDataOfCompanies: widget!.model!.leftDataOfCompanies!, ),
            ]))
      ])),
      SliverToBoxAdapter(child: SizedBox(height: 80))
    ]);
  }
}
