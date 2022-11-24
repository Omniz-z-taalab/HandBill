import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/home/home_event.dart';
import 'package:hand_bill/src/blocs/home/home_state.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/home/banner.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/repositories/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String tag = "HomeBloc";
  List<BannerModel> sliders = [];
  List<Company> topCompaniesList = [];
  List<Product> popularList = [];
  final HomeRepository homeRepository = HomeRepository();

  HomeBloc() : super(HomeInitialState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeFetchSliders) {
      yield* _mapSliders();
    }
    if (event is HomeFetchTopCompanies) {
      yield* _mapTopCompanies();
    }
    if (event is HomeFetchPopular) {
      yield* _mapPopular();
    }
  }

  Stream<HomeState> _mapSliders() async* {
    try {
      yield SliderLoadingState();
      final response = await homeRepository.geySliderData();
      if (response.status!) {
        final items = response.data;
        sliders = items!;
        yield SliderSuccessState(items: items);
      } else {
        yield SliderErrorState(errors: response.message.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<HomeState> _mapTopCompanies() async* {
    yield TopCompaniesLoadingState();
    print('isis');

    final response = await homeRepository.getTopCompaniesData();
    try {
      if (response.status!) {
        final items = response.data;
        print(items!.first.name);
        print('dataa');

        if(topCompaniesList.isEmpty)topCompaniesList = items!;
        yield TopCompaniesSuccessState(items: items);
      } else {
        yield TopCompaniesErrorState(errors: response.message.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<HomeState> _mapPopular() async* {
    try {
      yield PopularLoadingState();
      final response = await homeRepository.getPopularData();
      if (response.status!) {
        final items = response.data;
        popularList = items!;
        yield PopularSuccessState(items: items);
      } else {
        yield PopularErrorState(errors: response.message.toString());
      }
    } catch (e) {
      print(e);
    }
  }
}
