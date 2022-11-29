// ignore_for_file: unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/category/category_bloc.dart';
import 'package:hand_bill/src/blocs/about_us/abouUsBloc.dart';
import 'package:hand_bill/src/blocs/about_us/state.dart';
import 'package:hand_bill/src/blocs/category/category_bloc.dart';
import 'package:hand_bill/src/data/model/about_us/aboutUsModel.dart';
import 'package:hand_bill/src/data/response/aboutUs_response/abotus_response.dart';
import 'package:hand_bill/src/repositories/aboutUs_repository.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:video_player/video_player.dart';

import '../../blocs/about_us_bloc/about_us_bloc.dart';
import '../../data/model/about_us/aboutUsModel.dart';

class AboutUsScreen extends StatefulWidget {
  static const routeName = "/AboutUsScreen";

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  bool loading = false;

  // AboutUsBloc? aboutUsBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Videos>? list;
  ScrollController? _scrollController;
  late AboutUsBloc aboutUsBloc;
  CategoryBloc? _categoryBloc;

  @override
  void initState() {
    aboutUsBloc = BlocProvider.of<AboutUsBloc>(context);
    aboutUsBloc.add(FetchAboutItemEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AboutUsBloc, AboutUsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
              child: SizedBox(
                  height: 900,
                  width: double.infinity,
                  child: Scaffold(
                      appBar: AppBar(
                          leading: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          backgroundColor: Colors.white,
                          title: Text(
                            'AboutUs'.tr(),
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )),
                      body: SingleChildScrollView(
                          child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            height: 150,
                            width: 400,
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            'Video'.tr(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Container(
                            height: 150,
                            width: 400,
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            'About US Videos '.tr(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView(children: [
                            GridView.count(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
                                childAspectRatio: 1 / 0.7,
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                                shrinkWrap: true,
                                primary: false,
                                children: List.generate(4, (index) {
                                  return Container(
                                    color: Colors.amber,
                                    height: 100,
                                    width: 200,
                                  );
                                })),
                            SizedBox(height: 80),
                          ]),
                        )
                      ])))));
        });
  }
  Widget GetVideos(Videos data ){
    late VideoPlayerController controller = VideoPlayerController.network(
        data!.link == null ?
        "https://test.hand-bill.com/storage/uploads/about_us_app/video/1661279659_small_RZ75www1Ty.mp4"
            :data!.link!)..initialize();

    return InkWell(
      onTap: (){
        setState(() {
          controller.value.isPlaying
              ? controller.pause()
              : controller.play();
        });
      },
      child:Container(
        height: 80,
        width: 100,
        child: controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        )
            : Container(),//video player controller
        // allowScrubbing: true,

      ),

    );
  }

}
// =======
//   Widget build(BuildContext context){
//     return BlocConsumer<AboutUsBloc, ShopIntresStates>(
//   listener: (context, state) {
//     if(state is ShopIntresSuccessStates){
//       print(state.items!.banners!);
//       print('ppppaaaaaa');
//       if(list == null){
//       list = state.items!.videos!;
//       print(list);
//     }}
//   },
//   builder: (context, state) {
//     return SingleChildScrollView(
//       child: SizedBox(
//         height: 900,
//         width: double.infinity,
//         child: Scaffold(
//           appBar: AppBar(
//             leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){
//               Navigator.pop(context);
//             }),
//             backgroundColor: Colors.white,
//             title: Text('AboutUs'.tr(),style: TextStyle(color: Colors.black,fontSize: 15),)
//           ),
//           body: SingleChildScrollView(
//
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//
//                     Center(
//                       child: Container(
//                         height: 150,
//                         width: 400,
//                         color: Colors.amber,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Center(
//                       child: Text('Video'.tr(),style: TextStyle(color: Colors.black,fontSize: 20,),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Center(
//                       child: Container(
//                         height: 150,
//                         width: 400,
//                         color: Colors.amber,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Center(
//                       child: Text('About US Videos '.tr(),style: TextStyle(color: Colors.black,fontSize: 20,),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     SizedBox(
//                       height: 300,
//
//                       child:
//                       list ==null
//                           ?
//                       CircularProgressIndicator()
//                      : ListView(children: [
//                         GridView.count(
//                             padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
//                             childAspectRatio: 1 / 0.7,
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 2,
//                             mainAxisSpacing: 2,
//                             shrinkWrap: true,
//                             primary: false,
//                             children:
//                             List.generate(list!.length, (index) {
//                               return GetVideos(list![index]);
//                             })),
//                         SizedBox(height: 80),
//                       ]),
//                     ),
//                   ],
//                 ),
//               ),
//
//
//         ),
//
//       ),
//     );
//   },
//
// );
//
//   }


  // {
  //   return Scaffold(
  //       backgroundColor: Color(0xfff5f5f5),
  //       body: RefreshIndicator(
  //         onRefresh: () async {},
  //         child: BlocBuilder<AboutUsBloc, ShopIntresStates>(
  //             builder: (context, state) {
  //           if (state is ShopIntresErrorStates) {
  //             _list = [];
  //             SchedulerBinding.instance?.addPostFrameCallback((_) {
  //               displaySnackBar(
  //                   title: state.error.toString(), scaffoldKey: _scaffoldKey);
  //             });
  //           }
  //           if (state is ShopIntresSuccessStates) {
  //             if (_list == null) {
  //               _list = [];
  //             } else {}
  //           }
  //           // if (state is SubCategoriesSuccessState) {
  //           //   if (_subCategories == null) {
  //           //     _subCategories = [];
  //           //   }
  //           //   if (_selectedCategory != null &&
  //           //       state.items != null &&
  //           //       state.items!.length != 0) {
  //           //     if (_showRealLength == false) {
  //           //       SchedulerBinding.instance?.addPostFrameCallback((_) {
  //           //         setState(() {
  //           //           _showRealLength = true;
  //           //         });
  //           //       });
  //           //     }
  //           //     if (_subCategories!.length != 0 &&
  //           //         _subCategories!.first.id != state.items!.first.id) {
  //           //       _subCategories!.addAll(state.items!);
  //           //     } else if (_subCategories!.length == 0) {
  //           //       _subCategories!.addAll(state.items!);
  //           //     }
  //           //   }
  //           // }

  //           return CustomScrollView(
  //               physics: BouncingScrollPhysics(),
  //               controller: _scrollController,
  //               slivers: [
  //                 SliverToBoxAdapter(
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                         width: double.infinity,
  //                         height: 70,
  //                         // height: 160,
  //                         // color: Colors.red,
  //                         child: Directionality(
  //                           textDirection: TextDirection.ltr,
  //                           child: SizedBox(
  //                             height: 50,
  //                             child: ListView.separated(
  //                               scrollDirection: Axis.horizontal,
  //                               shrinkWrap: true,
  //                               itemBuilder: (context, index) {
  //                                 if (_aboutUsBloc!.aboutCat!.isNotEmpty) {
  //                                   return Container(
  //                                     child: Text('a'),
  //                                   );
  //                                   // return AboutUsWidget(
  //                                   //     model:
  //                                   //         _aboutUsBloc!.categories![index],
  //                                   //     onTap: () => onCategoryTap(
  //                                   //         _categoryBloc!.categories![index]));
  //                                 }
  //                                 return Container();
  //                               },
  //                               itemCount: _aboutUsBloc!.aboutCat!.length,
  //                               separatorBuilder:
  //                                   (BuildContext context, int index) =>
  //                                       SizedBox(
  //                                 width: 10,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Expanded(
  //                           flex: 3,
  //                           child: Container(
  //                               padding: EdgeInsets.only(bottom: 40),
  //                               decoration: BoxDecoration(
  //                                   color: Color(0xffffffff),
  //                                   border: Border.symmetric(
  //                                       vertical:
  //                                           BorderSide(color: Color(0xffeeeeee)))),
  //                               child: _categoryBloc!.categories == null
  //                                   ? ListView.builder(
  //                                       shrinkWrap: true,
  //                                       physics: BouncingScrollPhysics(),
  //                                       itemCount: 6,
  //                                       itemBuilder: (context, index) {
  //                                         return CategoryEmptyWidget();
  //                                       })
  //                                   : ListView.builder(
  //                                       shrinkWrap: true,
  //                                       physics: BouncingScrollPhysics(),
  //                                       itemCount: _categoryBloc!.categories!.length,
  //                                       itemBuilder: (context, index) {
  //                                         if (_categoryBloc!.categories!.isNotEmpty) {
  //                                           return CategoryWidget(
  //                                               model:
  //                                                   _categoryBloc!.categories![index],
  //                                               onTap: () => onCategoryTap(
  //                                                   _categoryBloc!.categories![index]));
  //                                         }
  //                                         return CategoryEmptyWidget();
  //                                       }))),
  //                       Container(
  //                         padding: EdgeInsets.only(bottom: 30),
  //                         margin: EdgeInsets.only(left: 6, right: 8),
  //                         child: Column(children: [
  //                           _subCategories == null ||
  //                                   _subCategories!.length == 0
  //                               ? ListView.separated(
  //                                   padding: EdgeInsets.symmetric(vertical: 12),
  //                                   primary: false,
  //                                   shrinkWrap: true,
  //                                   itemCount: 4,
  //                                   itemBuilder:
  //                                       (BuildContext context, int index) {
  //                                     return SubCategoryEmptyWidget();
  //                                   },
  //                                   separatorBuilder:
  //                                       (BuildContext context, int index) =>
  //                                           SizedBox(height: 8))
  //                               : ListView.separated(
  //                                   padding: EdgeInsets.symmetric(vertical: 12),
  //                                   primary: false,
  //                                   shrinkWrap: true,
  //                                   itemCount: _showRealLength == true
  //                                       ? _subCategories!.length
  //                                       : (_subCategories!.first.subSubCategory!
  //                                                   .length >
  //                                               6
  //                                           ? 1
  //                                           : 2),
  //                                   itemBuilder:
  //                                       (BuildContext context, int index) {
  //                                     return Stack(
  //                                       alignment: Alignment.bottomRight,
  //                                       children: [
  //                                         SubCategoryWidget(
  //                                             realLength: _showRealSubLengthIndex !=
  //                                                         null &&
  //                                                     _showRealSubLengthIndex ==
  //                                                         index
  //                                                 ? _subCategories![index]
  //                                                     .subSubCategory!
  //                                                     .length
  //                                                 : (_subCategories![index]
  //                                                             .subSubCategory!
  //                                                             .length >
  //                                                         10
  //                                                     ? 10
  //                                                     : (_subCategories![index]
  //                                                                 .subSubCategory!
  //                                                                 .length >=
  //                                                             5
  //                                                         ? 5
  //                                                         : 1)),
  //                                             model: _subCategories![index]),
  //                                         if (_subCategories![index]
  //                                                     .subSubCategory!
  //                                                     .length !=
  //                                                 0 &&
  //                                             _subCategories![index]
  //                                                     .subSubCategory!
  //                                                     .length >
  //                                                 3)
  //                                           Align(
  //                                             alignment: Alignment.bottomRight,
  //                                             child: GestureDetector(
  //                                                 onTap: () async {
  //                                                   setState(() {
  //                                                     _showRealSubLengthIndex =
  //                                                         index;
  //                                                   });
  //                                                 },
  //                                                 child: Container(
  //                                                   color: Colors.white,
  //                                                   margin:
  //                                                       EdgeInsets.symmetric(
  //                                                           horizontal: 15.w,
  //                                                           vertical: 20.h),
  //                                                   child: RichText(
  //                                                     softWrap: true,
  //                                                     maxLines: 2,
  //                                                     textAlign:
  //                                                         TextAlign.center,
  //                                                     text: TextSpan(children: [
  //                                                       if (_showRealSubLengthIndex !=
  //                                                           index)
  //                                                         TextSpan(
  //                                                           text: translate(
  //                                                               "button.show_more"),
  //                                                           style: TextStyle(
  //                                                             color: Colors.blue
  //                                                                 .withOpacity(
  //                                                                     0.5),
  //                                                             fontWeight:
  //                                                                 FontWeight
  //                                                                     .bold,
  //                                                             decoration:
  //                                                                 TextDecoration
  //                                                                     .underline,
  //                                                             fontSize: 25.sp,
  //                                                           ),
  //                                                         ),
  //                                                       TextSpan(text: " "),
  //                                                     ]),
  //                                                   ),
  //                                                 )),
  //                                           ),
  //                                       ],
  //                                     );
  //                                   },
  //                                   separatorBuilder:
  //                                       (BuildContext context, int index) =>
  //                                           SizedBox(height: 8)),
  //                         ]),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ]);
  //         }),
  //       ));
  // }
  //
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Color(0xfff5f5f5),
  //     body: RefreshIndicator(
  //       onRefresh: () async {},
  //       child: BlocListener<AboutUsBloc, ShopIntresStates>(
  //         listener: (context, state) => {},
  //         child: ConditionalBuilder(
  //           condition: AboutUsBloc.get(context).aboutUsModel != null,
  //           builder: (context) => getIntresItem(
  //             AboutUsBloc.get(context).aboutUsModel,
  //           ),
  //           fallback: (context) => Container(
  //             height: MediaQuery.of(context).size.height * 0.40,
  //             color: Colors.black.withOpacity(0.7),
  //             child: Center(
  //               child: CircularProgressIndicator(),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget getIntresItem(
  //   AboutUsModel model,
  // ) =>
  //     Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //           child: GridView.count(
  //               crossAxisCount: 2,
  //               mainAxisSpacing: 20.0,
  //               crossAxisSpacing: 10.0,
  //               childAspectRatio: 1 / 1.6,
  //               children: List.generate(model.videos!.length,
  //                   (index) => buildGridleProduct(model.videos![index])))),
  //     );
  //
  // Widget buildGridleProduct(
  //   Videos model,
  // ) =>
  //     Column(
  //       children: [
  //         InkWell(
  //           child: Padding(
  //             padding: const EdgeInsets.all(2.0),
  //             child: Container(
  //               height: 280,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(15),
  //                 color: Colors.white,
  //               ),
  //               child: ClipRRect(
  //                   borderRadius: BorderRadius.horizontal(
  //                       right: Radius.circular(8.0),
  //                       left: Radius.circular(8.0)),
  //                   child: Column(
  //                     children: [
  //                       Image.network(
  //                         model.link.toString(),
  //                         height: 180,
  //                         width: double.infinity,
  //                         fit: BoxFit.fill,
  //                       ),
  //                       Text(model.name.toString())
  //                     ],
  //                   )),
  //             ),
  //           ),
  //           onTap: () {
  //             showDialog(
  //                 context: context,
  //                 builder: (BuildContext context) {
  //                   return Theme(
  //                     data: ThemeData(
  //                         dialogBackgroundColor: Colors.grey.withOpacity(0.0)),
  //                     child: AlertDialog(
  //                       content: SingleChildScrollView(
  //                           child: Image.network(
  //                         model.link.toString(),
  //                       )),
  //                     ),
  //                   );
  //                 });
  //           },
  //         ),
  //
  //         // : Container(
  //         //     width: 180,
  //         //     color: KstorebuttonColor,
  //         //     child: Center(
  //         //       child: Text(
  //         //         "done",
  //         //         style: TextStyle(color: Colors.white),
  //         //       ),
  //         //     ),
  //         //   )
  //       ],
  //     );

   // GridView.count(
   //                            padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
   //                            childAspectRatio: 1 / 0.7,
   //                            crossAxisCount: 2,
   //                            crossAxisSpacing: 2,
   //                            mainAxisSpacing: 2,
   //                            shrinkWrap: true,
   //                            primary: false,
   //                            children: List.generate(_items.length, (index) {
   //                              return DrawerItemWidget(model: _items[index]);
   //                            }))
