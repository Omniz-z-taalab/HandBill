import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/company/company_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_state.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/chats/conversition_model.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/chat_user.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'component/company_board.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class
CompanyScreen extends StatefulWidget {
  static const routeName = "/CompanyScreen";
  final RouteArgument routeArgument;

  CompanyScreen({required this.routeArgument});

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  Company? company;
  String? savedId;
  List<Product> featuredList = [], productsList = [];
  List<CategoryModel> categories = [];
  CompanyBloc? _companyBloc;

  int cartCount = 0;

  User? _user;
  ConversationModel? _conversation;
  List<ChatUser> _users = [];
  late dynamic _companyId;

  @override
  void initState() {
    _companyId = widget.routeArgument.param!;
    // savedId = _company.id.toString();
    _companyBloc = BlocProvider.of<CompanyBloc>(context);
    _companyBloc!.page = 1;
    _companyBloc!
      ..add(FetchCompanyDetails(id: _companyId.toString()))
      ..add(FetchFeaturedProductCompany(id: _companyId.toString()))
      ..add(FetchCompanyProducts(companyId: _companyId.toString()));

      // ..add(FetchCompanyCategories(id: _companyId.toString()));
    _user = BlocProvider.of<GlobalBloc>(context).user;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  bool showContact = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RegularAppBar(
            label: 'Company Details', textStyle: TextStyle(fontSize: 15)),
        backgroundColor: Color(0xfffafafa),
        body: Stack(
          alignment: Alignment.bottomRight,
          children: [
            RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    featuredList.clear();
                    productsList.clear();
                    categories.clear();
                    _companyBloc!.page = 1;
                    _companyBloc!
                      ..add(FetchCompanyDetails(id: _companyId.toString()))
                      ..add(FetchFeaturedProductCompany(id: _companyId.toString()))
                      ..add(FetchCompanyProducts(companyId: _companyId.toString()));
                  });
                },
                child: MultiBlocListener(
                    listeners: [
                      BlocListener<CompanyBloc, CompanyState>(
                          listener: (context, state) {
                            if (state is GetCompanySuccessState) {
                              print('seeeeeeeee');

                              company = state.company!;
                                print('seeeeeeeee');
                            }
                            if (state is GetCompanyCategoriesSuccessState) {
                              setState(() {
                                categories.addAll(state.items!);
                              });
                            }
                            if (state is GetFeaturedProductCompanySuccessState) {
                              setState(() {
                                featuredList.addAll(state.items!);
                                _companyBloc!.isFetching = false;
                              });
                            }

                            if (state is GetCompanyProductsSuccessState) {
                              setState(() {
                                productsList.addAll(state.items!);
                              });
                            }
                            if (state is CompanyErrorState) {
                              Fluttertoast.showToast(msg: state.error.toString());
                            }
                          }),
                      BlocListener<FavoriteBloc, FavoriteState>(
                          listener: (context, state) {
                            if (state is AddToFavoriteSuccessState) {
                              Fluttertoast.showToast(msg: state.message!);
                            }
                            if (state is RemoveFromFavoriteSuccessState) {
                              Fluttertoast.showToast(msg: state.message!);
                            }
                          })
                    ],
                    child: company == null
                        ? CustomScrollView(slivers: [
                      SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()))
                    ])
                        : CompanyBoard(
                        model: company!,
                        featuredList: featuredList,
                        products: productsList,
                        categories: categories,
                        user: _user))),

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
                bottom: 500.h,
                right: 30.w,
                child:  Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: IconButton(
                    onPressed: ()async{
                      if (_user == null) {
                        Fluttertoast.showToast(msg: "toast.login".tr());
                      }else{
                        if (company!.deviceToken != null){
                          //?text=${Uri.parse(description)}
                          await canLaunch("https://wa.me/+2${company!.leftDataOfCompanies!.firstMobile!=null&&
                              company!.leftDataOfCompanies!.firstMobile!=''?company!.leftDataOfCompanies!.firstMobile:company!.firstPhone}")?
                          launch("https://wa.me/+2${company!.leftDataOfCompanies!.firstMobile!=null&&
                              company!.leftDataOfCompanies!.firstMobile!=''?company!.leftDataOfCompanies!.firstMobile:company!.firstPhone}")
                              :print("cannot launch");
                        }
                      }
                    },
                    color: Colors.transparent,
                    icon: Image.asset("assets/icons/whatsappp.png",
                    height: 100.h,width: 100.w,fit: BoxFit.cover,),),
                ),),
              Positioned(
                bottom: 360.h,
                right: 30.w,
                child:  Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: IconButton(
                    onPressed: ()async{
                      if (_user == null) {
                        Fluttertoast.showToast(msg: "toast.login".tr());
                      }else{
                        if (company!.deviceToken != null){
                          await canLaunch("tel:${company!.leftDataOfCompanies!.firstMobile!=null&&
                              company!.leftDataOfCompanies!.firstMobile!=''?company!.leftDataOfCompanies!.firstMobile:company!.firstPhone}")?
                          launch("tel:${company!.leftDataOfCompanies!.firstMobile!=null&&
                              company!.leftDataOfCompanies!.firstMobile!=''?company!.leftDataOfCompanies!.firstMobile:company!.firstPhone}")
                              :print("cannot launch");
                        }
                      }
                    },
                    color: Colors.white,
                    icon: Icon(Icons.phone,size: 30.w,),),
                ),),
              Positioned(
                bottom: 220.h,
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
                          path: '${company!.email}',
                          query: 'subject=Hand bill request &body=description',
                        );
                        final url = params.toString();
                        await canLaunch("$url")?
                            launch("$url"):
                            print("can not open gmail");
                      }
                    },
                    color: Colors.white,
                    icon: Icon(Icons.email,size: 30.w,),),
                ),
              ),
            ],

          ],
        )
    );
  }
}
