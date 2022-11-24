import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/explore/explore_bloc.dart';
import 'package:hand_bill/src/blocs/explore/explore_event.dart';
import 'package:hand_bill/src/blocs/explore/explore_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/explore_model.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ExploreScreen extends StatefulWidget {
  static const routeName = "/ExploreScreen";
  const ExploreScreen({Key? key}) : super(key: key);
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  ScrollController? _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  ExploreBloc? _exploreBloc;

  static const offsetVisibleThreshold = 50.0;

  void _playVideos() {
    _exploreBloc!.controllers.forEach((controller) {
      controller
        ..initialize().then((_) {
          setState(() {});
        });
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
  }

  bool isVideosPlaying() {
    for (VideoPlayerController controller in _exploreBloc!.controllers) {
      if (controller.value.isPlaying) {
        return true;
      }
    }
    return false;
  }


  @override
  void initState() {
    _exploreBloc = BlocProvider.of<ExploreBloc>(context);
    // if(_exploreBloc!.isLoaded==null){
    //   _exploreBloc!.isLoaded = false;
    //   Timer(Duration(seconds: 4),(){
    //     setState(() {
    //       _exploreBloc!.isLoaded = true;
    //       print("... set loaded true");
    //     });
    //   });
    // }
    _exploreBloc!.controllers.forEach((controller) {
      controller
        ..initialize().then((_) {
          setState(() {});
        });
    });
    _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }
  @override
  void dispose() {
    _scrollController!.dispose();
    _exploreBloc!.controllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void _onScroll() {
    final max = _scrollController!.position.maxScrollExtent;
    final offset = _scrollController!.offset;
    if (offset + offsetVisibleThreshold >= max &&
        !_exploreBloc!.isFetching) {
      setState(() {
        _exploreBloc!.isFetching = true;
      });
      _exploreBloc!.add(FetchExploreEvent());
    }
  }
  @override
  void didChangeDependencies() {
    _exploreBloc = BlocProvider.of<ExploreBloc>(context);
    // _exploreBloc!.page = 1;
    // _exploreBloc!.add(FetchExploreEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print("${_exploreBloc!.items!.length}");
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: RefreshIndicator(
          onRefresh: () async {

          },
          child: BlocListener<ExploreBloc, ExploreState>(
              listener: (context, state) {
                if (state is ExploreErrorState) {
                  displaySnackBar(
                      title: state.error!, scaffoldKey: _scaffoldKey);
                }
                if (state is ExploreSuccessState) {
                  setState(() {
                    // if (_items == null) {
                    //   _items = [];
                    // }
                    // _items!.addAll(state.items!);
                  });
                }
              },
              child:
              _exploreBloc!.controllers.first.value.isInitialized?
              CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: _scrollController,
                  slivers: [
                    _exploreBloc!.items == null
                        ? LoadingSliver()
                        : _exploreBloc!.items!.length == 0
                        ? CenterWidgetListSliver(
                        label: "explore is empty")
                        : SliverToBoxAdapter(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            // padding: EdgeInsets.symmetric(vertical: 16),
                            primary: false,
                            shrinkWrap: true,
                            itemCount: _exploreBloc!.items!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (ctx, index) {
                              VideoPlayerController controller = _exploreBloc!.controllers[index];
                              // controller.initialize().then((value) {});
                              return Container(
                                child: controller.value.isInitialized
                                    ? Container(
                                    margin: EdgeInsets.symmetric(vertical: 30.h,horizontal: 30.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          controller.value.isPlaying ?
                                          controller.pause() :
                                          controller.play();
                                        });
                                      },
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          Container(
                                            height: 400.h,
                                            child:  VideoPlayer(controller),
                                          ),
                                          ClosedCaption(text: null),

                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: Colors.white
                                              ),
                                              padding: EdgeInsets.all(4),
                                              margin: EdgeInsets.all(10),
                                              child: Text("Company $index",style: TextStyle(
                                                  color: Colors.black
                                              ),),
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: Colors.white
                                              ),
                                              padding: EdgeInsets.all(4),
                                              margin: EdgeInsets.all(10),
                                              child: Icon(
                                                controller.value.isPlaying?
                                                Icons.pause:Icons.play_arrow,
                                                color: mainColorLite,
                                              ),
                                            ),
                                          ),
                                          // Here you can also add Overlay capacities
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: VideoProgressIndicator(
                                              controller,
                                              allowScrubbing: true,
                                              padding: EdgeInsets.all(3),
                                              colors: VideoProgressColors(
                                                  playedColor: Theme.of(context).primaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                )
                                    : Container(child: Text("${controller.value.isInitialized}"),),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                Container(
                                    height: 10,
                                    color: Color(0xffeeeeee)))),
                    // SliverToBoxAdapter(child: SizedBox(height: 100)),
                    // SliverToBoxAdapter(
                    //     child: Container(
                    //         child: loading == true
                    //             ? Padding(
                    //             padding:
                    //             EdgeInsets.symmetric(vertical: 40),
                    //             child: Align(
                    //                 alignment: Alignment.bottomCenter,
                    //                 child: CircularProgressIndicator(
                    //                     strokeWidth: 2)))
                    //             : SizedBox()))
                  ]):
                  ListView.separated(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30.h,),
                          Image.asset("assets/images/loading.gif",fit: BoxFit.cover,
                            height:400.h,width: 900.w,),
                          SizedBox(height: 30.h,),
                          Container(
                            height: 60.h,width: 300.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: AssetImage("assets/images/loading.gif",
                                  ),
                                fit: BoxFit.cover,
                              )
                            ),
                          )
                        ],
                      );
                    }, separatorBuilder: (BuildContext context, int index)=> SizedBox(height: 20.h,),
                  )
          ))
    );
  }
}
