import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/data/model/explore_model.dart';
import 'package:video_player/video_player.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  String tag = "ExploreBloc";

  // ExploreRepository _exploreRepository = ExploreRepository();
  int page = 1;
  bool isFetching = true;

  ExploreBloc({required BuildContext context})
      : super(ExploreInitialState()) ;

  @override
  Stream<ExploreState> mapEventToState(ExploreEvent event) async* {
    if (event is FetchExploreEvent) {
      yield* _mapFetchExplore();
    }
  }

  List<ExploreModel>? items  = [];
  List<VideoPlayerController> controllers = [];
  bool? isLoaded;
  Stream<ExploreState> _mapFetchExplore() async* {
    if(items!.length==0){
      log("fetch videos list.....");
      // yield ExploreLoadingState();
      // final response = await _exploreRepository.getExploreData(page: page);
      // if (response.status!) {
      //   final items = response.data;
      items!.add(ExploreModel(link:"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"));
      items!.add(ExploreModel(link:"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"));
      items!.add(ExploreModel(link:"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"));
      items!.add(ExploreModel(link:"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"));
      items!.add(ExploreModel(link:"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"));
      items!.forEach((element) {
        controllers.add(VideoPlayerController.network(element.link!,
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true)));
      });
      emit(state);
      // yield ExploreSuccessState(items: items);
      // page++;
      // isFetching = false;
      // } else {
      //   yield ExploreErrorState(error: response.message);
      //   isFetching = false;
      // }
    }
  }
  
}
