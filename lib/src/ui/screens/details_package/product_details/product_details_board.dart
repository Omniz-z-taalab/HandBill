import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_event.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/data_variable.dart';
import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/model/shipping_data.dart';
import 'package:hand_bill/src/data/model/specifications.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/expandable_text.dart';
import 'package:hand_bill/src/ui/component/product/product_hor_empty_widget.dart';
import 'package:hand_bill/src/ui/component/product/product_hor_widget.dart';
import 'package:hand_bill/src/ui/screens/common/image_full_screen.dart';
import 'package:hand_bill/src/ui/screens/details_package/company/company_screen.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../../../blocs/products/products_bloc.dart';
import '../../../../data/response/search/search_product_response.dart';

class ProductDetailsBoard extends StatefulWidget {
  late DataProductSearch model;
  List<Product>? similarList = [];
  User? user;
  bool favotrite;

  ProductDetailsBoard(
      {required this.model,
      this.similarList,
      this.user,
      required this.favotrite});

  @override
  _ProductDetailsBoardState createState() => _ProductDetailsBoardState();
}

class _ProductDetailsBoardState extends State<ProductDetailsBoard> {
  late DataProductSearch _product;
  bool showAll = false;
  int length = 80;
  double radius = 12, marginTop = 16, _favSize = 50;
  List<Product> _similarList = [];

  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 100.0;
  late ProductsBloc _productsBloc;

  List<Specifications> _specifications = [];

  List<ImageModel> _imageList = [];
  int _imageIndex = 0;
  VideoPlayerController? _videoPlayerController1;
  ChewieController? _chewieController;
  bool _addVideo = false;

  late FavoriteBloc _favoriteBloc;
  User? _user;
  bool _favorite = false;
  ShippingData? _shippingData;
  List<DataVariable> _shippingList = [];

  @override
  void initState() {
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

    _scrollController = ScrollController()..addListener(_onScroll);
    // getData();

    super.initState();
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

  @override
  void didUpdateWidget(covariant ProductDetailsBoard oldWidget) {
    getData();

    super.didUpdateWidget(oldWidget);
  }

  Company _company = Company();
  String? _name = "";
  String? _flag = "";
  String? _natureActivity = "";
  String? _description = "";
  String _country = "";
   ShippingData? _mqo ;
  String _price = "";

  getData() async {
    _product = widget.model;
    _user = widget.user;
    if (_product.company != null) {
      _name = _product.name;
      _description = _product.name;
      _imageList = _product.images!;
      _country = _product.flag!;
      _price = _product.price!;
      _mqo = _product.shippingData! as ShippingData?;
      _specifications = _product.specifications!;
      _company = _product.company!;
      _flag = _product.flag;
      _natureActivity = _company.natureActivity;
      _similarList = widget.similarList!;
      _favorite = widget.favotrite;
      if (_product.video != null && _addVideo == false) {
        initializePlayer(_product.video!.url!);
      }
      if (_product.shippingData != null) {
        _shippingData = _product.shippingData as ShippingData?;
        if (_shippingList.length > 0) {
          _shippingList.clear();
          _shippingData!.toJson().forEach((key, value) {
            if (value != null) {
              _shippingList.add(DataVariable(
                  key: toBeginningOfSentenceCase(key.replaceAll("_", " ")),
                  value: value.toString()));
            }
          });
        } else {
          _shippingData!.toJson().forEach((key, value) {
            if (value != null) {
              _shippingList.add(DataVariable(
                  key: key.replaceAll("_", " "), value: value.toString()));
            }
          });
        }
      }
    }
  }

  void _onScroll() {
    final max = _scrollController!.position.maxScrollExtent;
    final offset = _scrollController!.offset;

    if (offset + offsetVisibleThreshold >= max && !_productsBloc.isFetching) {
      setState(() {
        _productsBloc.isFetching = true;
      });
      // _productsBloc
      //   ..add(FetchProductsBySubCategoryEvent(
      //       subcategoryId: _model.categoryId!, user: _user));
    }
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    if (_videoPlayerController1 != null) {
      _videoPlayerController1!.dispose();
      _chewieController!.dispose();
    }
    super.dispose();
  }

  _onFavTap() {
    if (_user != null) {
      if (_favorite == false) {
        _favoriteBloc
          ..add(
              AddToFavoriteEvent(user: widget.user!, productId: _product.id!));
      } else {
        _favoriteBloc
          ..add(RemoveFromFavoriteEvent(
              user: widget.user!, favoriteId: _product.id!));
      }
    } else {
      Fluttertoast.showToast(msg: "toast.login".tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            arguments:
                                RouteArgument(param: _imageList[index].url)),
                        child: CachedNetworkImage(
                            imageUrl: _imageList[index].url!,
                            placeholder: (context, url) => Center(
                                heightFactor: 1,
                                widthFactor: 1,
                                child: CircularProgressIndicator(
                                    color: mainColorLite, strokeWidth: 2)),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error, color: mainColorLite)),
                      );
                    }
                  })),
          Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: marginTop),
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
                    SizedBox(height: marginTop),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(_name.toString(),
                                  style: TextStyle(
                                      color: textDarkColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: marginTop),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: textDarkColor,
                                                fontSize: 14),
                                            children: [
                                          TextSpan(
                                              text: "MOQ : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13)),
                                          TextSpan(text: _mqo.toString()),
                                          TextSpan(text: " Pieces")
                                        ])),
                                  ]),
                            ])),
                        InkWell(
                            onTap: () => _onFavTap(),
                            child: Container(
                                height: _favSize,
                                width: _favSize,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(90)),
                                child: Icon(
                                    _favorite == false
                                        ? Icons.favorite_border
                                        : Icons.favorite,
                                    color: Colors.white)))
                      ],
                    ),
                    SizedBox(height: marginTop),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  color: Color(0xfff5f5f5),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Color(0xffeeeeee))),
                              child: Row(children: [
                                Text("Price",
                                    style: TextStyle(
                                        color: textDarkColor, fontSize: 14)),
                                SizedBox(width: 4),
                                Text("$_price \$ US",
                                    style: TextStyle(
                                        color: textDarkColor, fontSize: 14)),
                              ])),
                          Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Icon(Icons.location_on),
                                SizedBox(width: 8),
                                Text(_country.toString(),
                                    style: TextStyle(
                                        fontSize: 14, color: textDarkColor)),
                              ]))
                        ]),
                    SizedBox(height: marginTop)
                  ])),
          Container(
              margin: EdgeInsets.only(bottom: 16),
              width: double.infinity,
              height: 8,
              color: Color(0xffeeeeee)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          if (_videoPlayerController1 != null) {
                            _videoPlayerController1!.pause();
                            _chewieController!.pause();
                          }
                          Navigator.pushNamed(context, CompanyScreen.routeName,
                              arguments: RouteArgument(param: _company.id));
                        },
                        child: SizedBox(
                            height: 60,
                            child: Row(children: [
                              AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: Color(0xffeeeeee),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Color(0xffe0e0e0))),
                                      child:_company.logo!=null?
                                      CachedNetworkImage(
                                          imageUrl: _company.logo!.url!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Transform.scale(
                                                  scale: 0.4,
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: mainColorLite,
                                                          strokeWidth: 2)),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error)):Image.asset("assets/images/hb_logo.jpeg"))),
                              SizedBox(width: 16),
                              Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text("${_company.name}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: textDarkColor,
                                          // fontWeight: FontWeight.w500
                                        ),
                                        maxLines: 1),
                                    Text("VERIFIED MEMBER",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: textDarkColor,
                                          // fontWeight: FontWeight.w500
                                        ),
                                        maxLines: 1)
                                  ])),
                              SizedBox(width: 16),
                              Container(
                                  height: 24,
                                  width: 24,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4)),
                                  child: CachedNetworkImage(
                                      imageUrl: _flag ?? imageFlag,
                                      placeholder: (context, url) =>
                                          Transform.scale(
                                              scale: 0.4,
                                              child: CircularProgressIndicator(
                                                  color: mainColorLite,
                                                  strokeWidth: 2)),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error,
                                              color: mainColorLite))),
                            ]))),

                    // SizedBox(height: 16),
                  ])),
          _shippingData == null
              ? SizedBox()
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _divider(),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Packaging and Shipping",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start),
                            SizedBox(height: 16),
                            ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: _shippingList.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        ShippingRowWidget(
                                            model: _shippingList[index],
                                            index: index))
                          ]))
                ]),
          _divider(),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Specifications",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start),
                    SizedBox(height: 16),
                    ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: _specifications.length,
                        itemBuilder: (BuildContext context, int index) =>
                            DataRowWidget(
                                model: _specifications[index], index: index))
                  ])),
          _divider(),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start),
                    SizedBox(height: 16),
                    ExpandableTextWidget(text: _description.toString())
                  ])),
          _divider(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Similar products",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start)),
            // SizedBox(height: 16),
            Container(
                width: double.infinity,
                height: size.height * 0.4,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        _similarList.isNotEmpty ? _similarList.length : 6,
                    itemBuilder: (context, index) {
                      // if (_productsBloc.isFetching == true) {
                      //   return ProductVerEmptyWidget();
                      // }

                      if (_similarList.isNotEmpty) {
                        return ProductHorWidget(
                            model: _similarList[index],
                            user: widget.user,
                            favoriteBloc: _favoriteBloc,
                            canFav: false);
                      }
                      return ProductHorEmptyWidget();
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(width: 8))),
          ]),
          SizedBox(height: marginTop * 2)
        ]));
  }

  Widget _divider() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        height: 8,
        color: Color(0xffeeeeee));
  }
}

class ShippingRowWidget extends StatelessWidget {
  final int index;
  final DataVariable model;

  ShippingRowWidget({required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: index.isEven ? Color(0xfff5f5f5) : Color(0xfffafafa),
            border: Border.all(
                color: index.isEven ? Color(0xffeeeeee) : Color(0xffffff))),
        child: Row(children: [
          Expanded(
              child: Text(model.key!,
                  style: TextStyle(
                      fontSize: 14,
                      color: textDarkColor,
                      fontWeight: FontWeight.w500))),
          SizedBox(width: 16),
          Expanded(
              child: Text(model.value!,
                  style: TextStyle(fontSize: 14, color: textDarkColor)))
        ]));
  }
}

class DataRowWidget extends StatelessWidget {
  final Specifications model;
  final int index;

  DataRowWidget({required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: index.isEven ? Color(0xfff5f5f5) : Color(0xfffafafa),
            border: Border.all(
                color: index.isEven ? Color(0xffeeeeee) : Color(0xffffff))),
        child: Row(children: [
          Expanded(
              child: Text(model.key ?? "",
                  style: TextStyle(
                      fontSize: 14,
                      color: textDarkColor,
                      fontWeight: FontWeight.w500))),
          SizedBox(width: 16),
          Expanded(
              child: Text(model.value ?? "",
                  style: TextStyle(fontSize: 14, color: textDarkColor)))
        ]));
  }
}
