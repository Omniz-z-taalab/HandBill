import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/chats/conversition_model.dart';
import 'package:hand_bill/src/data/model/local/chat_user.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/services/job_company_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/expandable_text.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/screens/common/image_full_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class JobCompanyDetailsScreen extends StatefulWidget {
  static const routeName = "/JobCompanyDetailsScreen";
  final RouteArgument routeArgument;

  JobCompanyDetailsScreen({required this.routeArgument});

  @override
  _JobCompanyDetailsScreenState createState() =>
      _JobCompanyDetailsScreenState();
}

class _JobCompanyDetailsScreenState extends State<JobCompanyDetailsScreen> {
  late JobCompanyModel _model;

  User? _user;
  ConversationModel? _conversation;
  List<ChatUser> _users = [];

  @override
  void initState() {
    _model = widget.routeArgument.param;
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
      _conversation = ConversationModel(users: _users);
    }

    super.initState();
  }
  bool showContact = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: RegularAppBar(label: 'Details'.tr()),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: mainColorLite,
        //     onPressed: () {
        //       if (_user == null) {
        //         Fluttertoast.showToast(msg: "login first");
        //       } else {
        //         _conversation = _conversation;
        //         // Navigator.pushNamed(context, InboxScreen.routeName,
        //         //     arguments: RouteArgument(param: _conversation));
        //       }
        //     },
        //     child: Icon(Icons.chat_outlined)),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                          child: SizedBox(
                              height: size.height * 0.15,
                              child: Row(children: [
                                InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, ImageFullScreen.routeName,
                                        arguments: RouteArgument(param: _model.company!.logo!.url)),
                                    child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              border:
                                              Border.all(color: Color(0xffe0e0e0))),
                                          child: CachedNetworkImage(
                                              imageUrl: _model.company!.logo!.url!,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Transform.scale(
                                                      scale: 0.4,
                                                      child: CircularProgressIndicator(
                                                          color: mainColorLite,
                                                          strokeWidth: 2)),
                                              errorWidget: (context, url, error) =>
                                              new Icon(Icons.error)),
                                        ))),
                                SizedBox(width: 16),
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(_model.company!.name.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14)),
                                              SizedBox(height: 8),
                                              Text(
                                                  _model.company!.leftDataOfCompanies ==
                                                      null
                                                      ? ""
                                                      : _model.company!
                                                      .leftDataOfCompanies!.address
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14)),
                                              SizedBox(height: 8),
                                              Text(timeago.format(_model.dateTime!),
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 13)),
                                            ]))),
                              ]))),
                      _divider(),
                      Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                          child: Row(children: [
                            Text(_model.title!,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500))
                          ])),
                      // SizedBox(height: 16),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Job Description",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(height: 16),
                                ExpandableTextWidget(
                                    text: _model.description.toString())
                              ])),
                      SizedBox(height: 100),
                    ])),
              ),
              Positioned(
                bottom: 70.h,
                right: 30.w,
                child:   InkWell(
                  onTap: (){
                    setState(() {
                      showContact = !showContact;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(showContact?Icons.close:Icons.chat,size: 30.w,
                      color: Colors.white,),
                  ),
                ),),
              if(showContact==true)...[
                Positioned(
                  bottom: 400.h,
                  right: 30.w,
                  child:  Container(
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: IconButton(
                      onPressed: ()async{
                        if (_user == null) {
                          Fluttertoast.showToast(msg:"login".tr());
                        }else{
                          if (_model.company!.deviceToken != null){
                            //?text=${Uri.parse(description)}
                            await canLaunch("https://wa.me/+2${_model.company!.leftDataOfCompanies!.firstMobile!=null&&
                            _model.company!.leftDataOfCompanies!.firstMobile!=''?
                        _model.company!.leftDataOfCompanies!.firstMobile:
                        _model.company!.firstPhone}")?
                            launch("https://wa.me/+2${_model.company!.leftDataOfCompanies!.firstMobile!=null&&
                            _model.company!.leftDataOfCompanies!.firstMobile!=''?
                        _model.company!.leftDataOfCompanies!.firstMobile:
                        _model.company!.firstPhone}")
                                :print("cannot launch");
                          }
                        }
                      },
                      color: Colors.transparent,
                      icon: Image.asset("assets/icons/whatsappp.png",
                        height: 100.h,width: 100.w,fit: BoxFit.cover,),),
                  ),),
                Positioned(
                  bottom: 300.h,
                  right: 30.w,
                  child:  Container(
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: IconButton(
                      onPressed: ()async{
                        if (_user == null) {
                          Fluttertoast.showToast(msg: "login".tr());
                        }else{
                          if (_model.company!.deviceToken != null){
                            await canLaunch("tel:${_model.company!.leftDataOfCompanies!.firstMobile!=null&&
                            _model.company!.leftDataOfCompanies!.firstMobile!=''?
                        _model.company!.leftDataOfCompanies!.firstMobile:
                        _model.company!.firstPhone}")?
                            launch("tel:${_model.company!.leftDataOfCompanies!.firstMobile!=null&&
                            _model.company!.leftDataOfCompanies!.firstMobile!=''?
                        _model.company!.leftDataOfCompanies!.firstMobile:
                        _model.company!.firstPhone}")
                                :print("cannot launch");
                          }
                        }
                      },
                      color: Colors.white,
                      icon: Icon(Icons.phone,size: 25.w,),),
                  ),),
                Positioned(
                  bottom: 190.h,
                  right: 30.w,
                  child: Container(
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: IconButton(
                      onPressed: ()async{
                        if (_user == null) {
                          Fluttertoast.showToast(msg: "login".tr());
                        }else{
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: '${_model.company!.email}',
                            query: 'subject=Hand bill request &body=description',
                          );
                          final url = params.toString();
                          await canLaunch("$url")?
                          launch("$url"):
                          print("can not open gmail");
                        }
                      },
                      color: Colors.white,
                      icon: Icon(Icons.email,size: 25.w,),),
                  ),
                ),
              ],
            ],
          ),
        ));
  }

  Widget _divider() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        width: double.infinity,
        height: 2,
        color: Color(0xffeeeeee));
  }
}
