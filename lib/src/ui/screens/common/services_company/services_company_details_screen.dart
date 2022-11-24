// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hand_bill/src/blocs/company/company_bloc.dart';
// import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
// import 'package:hand_bill/src/common/constns.dart';
// import 'package:hand_bill/src/data/model/chats/conversition_model.dart';
// import 'package:hand_bill/src/data/model/company.dart';
// import 'package:hand_bill/src/data/model/local/chat_user.dart';
// import 'package:hand_bill/src/data/model/local/route_argument.dart';
// import 'package:hand_bill/src/data/model/user.dart';
// import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
// import 'package:hand_bill/src/ui/screens/common/services_company/services_company_board.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ServicesCompanyDetailsScreen extends StatefulWidget {
//   static const routeName = "/ServicesCompanyDetailsScreen";
//   final RouteArgument routeArgument;

//   ServicesCompanyDetailsScreen({required this.routeArgument});

//   @override
//   _ServicesCompanyDetailsScreenState createState() =>
//       _ServicesCompanyDetailsScreenState();
// }

// class _ServicesCompanyDetailsScreenState
//     extends State<ServicesCompanyDetailsScreen> {
//   User? _user;
//   ConversationModel? _conversation;
//   List<ChatUser> _users = [];

//   Company? _company;
//   String image = placeholder;
//   late CompanyBloc _companyBloc;
//   late int _companyId;

//   @override
//   void initState() {
//     _company = Company();
//     _companyId = widget.routeArgument.param;
//     _user = BlocProvider.of<GlobalBloc>(context).user;
//     _companyBloc = BlocProvider.of<CompanyBloc>(context);
//     _companyBloc.add(FetchCompanyDetails(id: _companyId.toString()));

//     _user = BlocProvider.of<GlobalBloc>(context).user;

//     super.initState();
//   }
//   bool showContact = false;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: RegularAppBar(label: 'Company Details'),
//         body: Stack(
//           children: [
//             BlocListener<CompanyBloc, CompanyState>(
//                 listener: (context, state) {
//                   if (state is GetCompanySuccessState) {
//                     setState(() {
//                       _company = state.company!;
//                     });
//                   }

//                   if (state is CompanyErrorState) {
//                     Fluttertoast.showToast(msg: state.error.toString());
//                   }
//                 },
//                 child: CustomScrollView(
//                     physics: BouncingScrollPhysics(), slivers: [
//                   _company!.leftDataOfCompanies == null
//                       ? SliverFillRemaining(
//                       child: Center(child: Text("company data not completed yet",
//                       style: TextStyle(color: mainColor),)))
//                       : SliverToBoxAdapter(
//                       child: ServicesCompanyBoard(company: _company!))
//                 ])),
//             Positioned(
//               bottom: 70.h,
//               right: 30.w,
//               child:   InkWell(
//                 onTap: (){
//                   setState(() {
//                     showContact = !showContact;
//                   });
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: mainColor,
//                       borderRadius: BorderRadius.circular(30)
//                   ),
//                   padding: EdgeInsets.all(12),
//                   child: Icon(showContact?Icons.close:Icons.chat,size: 60.w,
//                     color: Colors.white,),
//                 ),
//               ),),
//             if(showContact==true)...[
//               Positioned(
//                 bottom: 500.h,
//                 right: 30.w,
//                 child:  Container(
//                   decoration: BoxDecoration(
//                       color: mainColor,
//                       borderRadius: BorderRadius.circular(30)
//                   ),
//                   child: IconButton(
//                     onPressed: ()async{
//                       if (_user == null) {
//                         Fluttertoast.showToast(msg: translate("toast.login"));
//                       }else{
//                         if (_company!.deviceToken != null){
//                           //?text=${Uri.parse(description)}
//                           await canLaunch("https://wa.me/+2${_company!.leftDataOfCompanies!.firstMobile!=null&&
//                               _company!.leftDataOfCompanies!.firstMobile!=''?_company!.leftDataOfCompanies!.firstMobile:_company!.firstPhone}")?
//                           launch("https://wa.me/+2${_company!.leftDataOfCompanies!.firstMobile!=null&&
//                               _company!.leftDataOfCompanies!.firstMobile!=''?_company!.leftDataOfCompanies!.firstMobile:_company!.firstPhone}")
//                               :print("cannot launch");
//                         }
//                       }
//                     },
//                     color: Colors.transparent,
//                     icon: Image.asset("assets/icons/whatsappp.png",
//                       height: 100.h,width: 100.w,fit: BoxFit.cover,),),
//                 ),),
//               Positioned(
//                 bottom: 360.h,
//                 right: 30.w,
//                 child:  Container(
//                   decoration: BoxDecoration(
//                       color: mainColor,
//                       borderRadius: BorderRadius.circular(30)
//                   ),
//                   child: IconButton(
//                     onPressed: ()async{
//                       if (_user == null) {
//                         Fluttertoast.showToast(msg: translate("toast.login"));
//                       }else{
//                         if (_company!.deviceToken != null){
//                           await canLaunch("tel:${_company!.leftDataOfCompanies!.firstMobile!=null&&
//                               _company!.leftDataOfCompanies!.firstMobile!=''?_company!.leftDataOfCompanies!.firstMobile:_company!.firstPhone}")?
//                           launch("tel:${_company!.leftDataOfCompanies!.firstMobile!=null&&
//                               _company!.leftDataOfCompanies!.firstMobile!=''?_company!.leftDataOfCompanies!.firstMobile:_company!.firstPhone}")
//                               :print("cannot launch");
//                         }
//                       }
//                     },
//                     color: Colors.white,
//                     icon: Icon(Icons.phone,size: 60.w,),),
//                 ),),
//               Positioned(
//                 bottom: 220.h,
//                 right: 30.w,
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: mainColor,
//                       borderRadius: BorderRadius.circular(30)
//                   ),
//                   child: IconButton(
//                     onPressed: ()async{
//                       if (_user == null) {
//                         Fluttertoast.showToast(msg: translate("toast.login"));
//                       }else{
//                         final Uri params = Uri(
//                           scheme: 'mailto',
//                           path: '${_company!.email}',
//                           query: 'subject=Hand bill request &body=description',
//                         );
//                         final url = params.toString();
//                         await canLaunch("$url")?
//                         launch("$url"):
//                         print("can not open gmail");
//                       }
//                     },
//                     color: Colors.white,
//                     icon: Icon(Icons.email,size: 60.w,),),
//                 ),
//               ),
//             ],
//           ],
//         ));
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/ui/screens/common/image_full_screen.dart';
import 'package:hand_bill/src/ui/screens/common/services_company/services_company_board.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/constns.dart';
import '../../../../data/model/LeftDetailsOfCompany.dart';
import '../../../../data/model/local/data_variable.dart';
import '../../../../data/model/local/images.dart';
import '../../../../data/model/local/route_argument.dart';
import '../../../component/custom/expandable_text.dart';
import '../../../component/custom/regular_app_bar.dart';
import '../../details_package/company/component/company_profile.dart';

class ServicesCompanyDetailsScreen extends StatefulWidget {
  static const routeName = "/ServicesCompanyDetailsScreen";
  String logo;
  String name;
  String adresses;
  String website;

  String phone;

  String email;
  String whatsapp;

  ServicesCompanyDetailsScreen({
    required this.logo,
    required this.name,
    required this.adresses,
    required this.phone,
    required this.email,
    required this.website,
    required this.whatsapp,
  });

  @override
  State<ServicesCompanyDetailsScreen> createState() =>
      _ServicesCompanyDetailsScreenState();
}

class _ServicesCompanyDetailsScreenState
    extends State<ServicesCompanyDetailsScreen> {
  bool showContact = false;
  int _imageIndex = 0;
  List<ImageModel> _images = [];

  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;

  Company? _company;

  String _address = "", _phone = "", _services = "", _name = "";

  LeftDataOfCompanies? _dataOfCompanies;
  List<DataVariable> _dataList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: RegularAppBar(label: 'Company Details'),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Column(children: [
            //   Stack(children: [
            //     Container(
            //         height: size.height * 0.25,
            //         color: Colors.white,
            //         child: PageView.builder(
            //             itemCount: _images.length,
            //             controller: PageController(viewportFraction: 1),
            //             onPageChanged: (int index) {
            //               setState(() => _imageIndex = index);
            //               if (index == 1 && _chewieController != null) {
            //                 _videoPlayerController1.pause();
            //               }
            //             },
            //             itemBuilder: (BuildContext context, int index) {
            //               if (index == 0 && _chewieController != null) {
            //                 return Container(
            //                     color: Color(0xff000000),
            //                     child: Chewie(controller: _chewieController!));
            //               } else {
            //                 return InkWell(
            //                     onTap: () => Navigator.pushNamed(
            //                         context, ImageFullScreen.routeName,
            //                         arguments:
            //                             RouteArgument(param: _images[index].url)),
            //                     child: CachedNetworkImage(
            //                         imageUrl: _images[index].url!,
            //                         fit: BoxFit.cover,
            //                         placeholder: (context, url) => Center(
            //                             heightFactor: 1,
            //                             widthFactor: 1,
            //                             child: CircularProgressIndicator(
            //                                 color: mainColorLite,
            //                                 strokeWidth: 2)),
            //                         errorWidget: (context, url, error) =>
            //                             new Image.asset(
            //                               "assets/images/hb_logo.jpeg",
            //                               fit: BoxFit.contain,
            //                             )));
            //               }
            //             })),
            //     Positioned(
            //         bottom: 16,
            //         left: 16,
            //         child: InkWell(
            //             onTap: () => Navigator.pushNamed(
            //                 context, ImageFullScreen.routeName,
            //                 arguments: RouteArgument(param: _company!.logo!.url)),
            //             child: Container(
            //               clipBehavior: Clip.hardEdge,
            //               height: size.width * 0.18,
            //               width: size.width * 0.18,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   color: Color(0xffffffff)),
            //               child: CachedNetworkImage(
            //                   imageUrl: widget.routeArgument!.param.toString(),
            //                   fit: BoxFit.cover,
            //                   placeholder: (context, url) => Transform.scale(
            //                       scale: 0.4,
            //                       child: CircularProgressIndicator(
            //                           color: mainColorLite, strokeWidth: 2)),
            //                   errorWidget: (context, url, error) =>
            //                       new Image.asset(
            //                         "assets/images/hb_logo.jpeg",
            //                         fit: BoxFit.contain,
            //                       )),
            //             ))),
            //     _images.isEmpty
            //         ? SizedBox()
            //         : Positioned(
            //             bottom: 8,
            //             left: 0,
            //             right: 0,
            //             child: DotsIndicator(
            //                 dotsCount: _images.length,
            //                 position: _imageIndex.toDouble(),
            //                 decorator: DotsDecorator(
            //                     color: Color(0x66ffffff),
            //                     activeColor: Color(0xffffffff),
            //                     size: const Size(6.0, 4.0),
            //                     activeSize: const Size(12.0, 4.0),
            //                     activeShape: RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(20.0)))))
            //   ]),
            // ]),
            _divider(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffeeeeee),

                          borderRadius: BorderRadius.circular(16)
                        ),
                        width: double.infinity,
                        height: 150,
                        child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: '${APIData.domainLink}${widget.logo}',
                            placeholder: (context, url) => FittedBox(
                                child: Transform.scale(
                                    scale: 0.2,
                                    child: CircularProgressIndicator(
                                        color: mainColorLite,
                                        strokeWidth: 2))),
                            errorWidget: (context, url, error) =>
                            new Icon(Icons.error, color: mainColorLite)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(widget.name,
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xffe0e0e0))),
                          child: Column(children: [
                            widget.adresses.toString() != 'null'
                                ? Row(children: [
                                    Icon(Icons.location_on),
                                    SizedBox(width: 12),
                                    Expanded(
                                        child: Text(widget.adresses,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: textLiteColor)))
                                  ])
                                : Text(''),
                            SizedBox(height: 16),
                            Row(children: [
                              Icon(Icons.phone_android),
                              SizedBox(width: 12),
                              Expanded(
                                  child: widget.phone.toString() != 'null'
                                      ? Text(widget.phone,
                                          style: TextStyle(
                                              fontSize: 15, color: textLiteColor))
                                      : Text(''))
                            ]),
                            SizedBox(height: 16),
                            Row(children: [
                              Icon(Icons.whatsapp),
                              SizedBox(width: 12),
                              Expanded(
                                  child: widget.whatsapp.toString() != 'null'
                                      ? Text(widget.whatsapp,
                                          style: TextStyle(
                                              fontSize: 15, color: textLiteColor))
                                      : Text(''))
                            ]),
                            SizedBox(height: 16),
                            Row(children: [
                              Icon(Icons.email),
                              SizedBox(width: 12),
                              Expanded(
                                  child: widget.email.toString() != 'null'
                                      ? Text(widget.email,
                                          style: TextStyle(
                                              fontSize: 15, color: textLiteColor))
                                      : Text(''))
                            ]),
                            SizedBox(height: 16),
                            Row(children: [
                              Icon(Icons.web_asset),
                              SizedBox(width: 12),
                              Expanded(
                                  child: widget.website.toString() != 'null'
                                      ? Text(widget.website,
                                          style: TextStyle(
                                              fontSize: 15, color: textLiteColor))
                                      : Text(''))
                            ]),
                          ]))
                    ])),
            SizedBox(height: 24),

            // _divider(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
          ]),
        ));
  }

  Widget _divider() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        width: double.infinity,
        height: 2,
        color: Color(0xffeeeeee));
  }

  // Future<void> initializePlayer(String url) async {
  //   _videoPlayerController1 = VideoPlayerController.network(url);
  //   await _videoPlayerController1.initialize();
  //   _createChewieController();
  //   setState(() {
  //     _images.insert(0, ImageModel());
  //   });
  // }

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
