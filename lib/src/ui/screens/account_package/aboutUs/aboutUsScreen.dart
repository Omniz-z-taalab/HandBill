// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/category/category_bloc.dart';

import 'package:video_player/video_player.dart';

import '../../../../blocs/about_us_bloc/about_us_bloc.dart';
import '../../../../common/api_data.dart';
import '../../../../common/constns.dart';
import '../../../../data/response/aboutUs_response/AboutResponse.dart';
import '../../navigation_package/home/componenet/slider_empty_widget.dart';

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
  AboutUsBloc? aboutUsBloc;
  CategoryBloc? _categoryBloc;
  List<Banners>? banner;

  @override
  void initState() {
    aboutUsBloc = BlocProvider.of<AboutUsBloc>(context);
    aboutUsBloc!.add(FetchAboutItemEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AboutUsBloc, AboutUsState>(listener: (context, state) {
      if (state is AboutUsSuccessStates) {
        banner = state.items!.banners;
        print(banner![0].id);
        list = state.items!.videos;
        print(list![0].link);
        print('........');
        print('........');
      }
    }, builder: (context, state) {
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
                  body: RefreshIndicator(
                    onRefresh: () async {

                      aboutUsBloc!.add(FetchAboutItemEvent());
                    },
                    child: SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            banner == null
                                ? Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(30),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : CarouselSlider.builder(
                                    itemCount:
                                        banner!.isNotEmpty ? banner!.length : 6,
                                    itemBuilder: (BuildContext context,
                                        int index, int idx) {
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
                                        autoPlayInterval:
                                            Duration(milliseconds: 4000),
                                        autoPlayCurve: Curves.easeOutSine,
                                        clipBehavior: Clip.antiAlias,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _sliderPosition = index;
                                          });
                                        }),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          'AboutUSVideos'.tr(),
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
                        height: 500,
                        child: ListView(children: [
                          list == null
                              ? Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(30),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : GridView.count(
                                  padding: EdgeInsets.all(10),
                                  childAspectRatio: 1 / 0.7,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  shrinkWrap: true,
                                  primary: false,
                                  children:
                                      List.generate(list!.length, (index) {
                                    return VideoPlayerr(
                                      data: list![index],
                                    );
                                  })),
                          SizedBox(height: 100),
                        ]),
                      )
                    ])),
                  ))));
    });
  }
}

class VideoPlayerr extends StatefulWidget {
  Videos data;

  VideoPlayerr({required this.data}) : super();

  @override
  State<VideoPlayerr> createState() => _VideoPlayerrState();
}

class _VideoPlayerrState extends State<VideoPlayerr> {
  late VideoPlayerController controller;

  late ChewieController _chewieController;
  double _aspectRatio = 16 / 9;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(
        "${widget.data.link == null ? 'https://www.fluttercampus.com/video.mp4' : widget!.data!.link} ");
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void initState() {
    loadVideoPlayer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

          InkWell(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }

            setState(() {});
          },
          child: Card(
              elevation: 5,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child:
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                    // allowScrubbing: true,
                  ),
              ));
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
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: '${APIData.domainLink}${model.thump}',
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
