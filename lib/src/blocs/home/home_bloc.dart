import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/home/banner.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String tag = "HomeBloc";
  List<BannerModel> sliders = [];
  List<Company> topCompaniesList = [];
  List<Product> popularList = [];
  final HomeRepository homeRepository = HomeRepository();

  HomeBloc() : super(HomeInitialState()) {
    on<HomeFetchSliders>(_mapSliders);
    on<HomeFetchTopCompanies>(_mapTopCompanies);
    on<HomeFetchPopular>(_mapPopular);
  }

  void _mapSliders(HomeFetchSliders event, Emitter<HomeState> emit) async {
    try {
      emit(SliderLoadingState());
      final response = await homeRepository.geySliderData();
      if (response.status == true) {
        final items = response.data;
        sliders = items!;
        emit(SliderSuccessState(items: items));
      } else {
        emit(SliderErrorState(errors: response.message.toString()));
      }
    } catch (e) {
      print(e);
    }
  }

  void _mapTopCompanies(
      HomeFetchTopCompanies event, Emitter<HomeState> emit) async {
    emit(TopCompaniesLoadingState());
    print('isis');

    final response = await homeRepository.getTopCompaniesData();
    try {
      if (response.status!) {
        final items = response.data;
        print(items!.first.name);
        print('dataa + ');

        if (topCompaniesList.isEmpty) topCompaniesList = items;
        emit(TopCompaniesSuccessState(items: items));
      } else {
        emit(TopCompaniesErrorState(errors: response.message.toString()));
      }
    } catch (e) {
      print(e);
    }
  }

  void _mapPopular(HomeFetchPopular, Emitter<HomeState> emit) async {
    try {
      emit(PopularLoadingState());
      final response = await homeRepository.getPopularData();
      if (response.status!) {
        final items = response.data;
        popularList = items!;
        emit(PopularSuccessState(items: items));
      } else {
        emit(PopularErrorState(errors: response.message.toString()));
      }
    } catch (e) {
      print(e);
    }
  }
}
