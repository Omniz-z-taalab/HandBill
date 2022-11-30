// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
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
import '../../common/api_data.dart';
import '../../common/constns.dart';
import '../../data/model/about_us/aboutUsModel.dart';
import '../../data/response/aboutUs_response/AboutResponse.dart';
import 'details_package/company/company_screen.dart';
import 'navigation_package/categories/widgets/bannersubpro_widget.dart';
import 'navigation_package/home/componenet/slider_empty_widget.dart';

class AboutUsScreen extends StatefulWidget {
  static const routeName = "/AboutUsScreen";

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  bool loading = false;
  int _sliderPosition = 0;

  // AboutUsBloc? aboutUsBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Videos>? list;
  ScrollController? _scrollController;
  late AboutUsBloc aboutUsBloc;
  CategoryBloc? _categoryBloc;
   List<Banners>? banner;

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
        listener: (context, state) {
          if(state is AboutUsSuccessStates){
            banner = state.items!.banners;
            print(banner![0].id);
            list = state.items!.videos;

          }
        },
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
                          child:  Stack(
                              children: [
                                banner == null ?
                                 Container()
                                :CarouselSlider.builder(
                                  itemCount: banner!.isNotEmpty
                                      ? banner!.length
                                      : 6,
                                  itemBuilder:
                                      (BuildContext context, int index, int idx) {
                                    if (banner!.isNotEmpty) {
                                      return SliderAboutWidget(
                                          model: banner![index]);
                                    }
                                    return SliderEmptyWidget();
                                  },
                                  options: CarouselOptions(
                                      viewportFraction: 1,
                                      initialPage: 0,
                                      // enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      autoPlay: true,
                                      enableInfiniteScroll: true,
                                      autoPlayInterval: Duration(milliseconds: 4000),
                                      autoPlayCurve: Curves.easeOutSine,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _sliderPosition = index;
                                        });
                                      }),
                                ),
                              ],
                            ),),
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
                                  return GetVideos(list![index]);
                                })),
                            SizedBox(height: 80),
                          ]),
                        )
                        ])))
              ));
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
class SliderAboutWidget extends StatelessWidget {
  final Banners model;

  SliderAboutWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        // onTap: () {
        //
        //   Navigator.pushNamed(context, CompanyScreen.routeName,
        //       arguments: RouteArgument(param: model!.id));
        //
        // },
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Color(0xfff5f5f5), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xfff5f5f5),
                        blurRadius: 3,
                        spreadRadius: 3)
                  ]),
              child: CachedNetworkImage(

                imageUrl:'${APIData.domainLink}${model.thump}',
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                    heightFactor: 3,
                    widthFactor: 2,
                    child: CircularProgressIndicator(
                        color: mainColorLite, strokeWidth: 1)),
                // errorWidget: (context, url, error) =>
                // new Icon(Icons.error, color: mainColorLite)),
              ),
            )));
  }
}
