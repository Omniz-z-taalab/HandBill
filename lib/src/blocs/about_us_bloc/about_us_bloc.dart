import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// import '../../data/model/about_us/aboutUsModel.dart';
import '../../data/response/aboutUs_response/AboutResponse.dart';
import '../../repositories/about_us_repo.dart';

part 'about_us_event.dart';

part 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  AboutUsRepo aboutUsRepo = AboutUsRepo();
  List<Videos>? aboutCat;

  AboutUsBloc() : super(AboutUsInitial()) {
    on<FetchAboutItemEvent>(fetchAbout);
  }

  void fetchAbout(FetchAboutItemEvent event, Emitter<AboutUsState> emit) async {
    AboutResponse? response;
    response = await aboutUsRepo.getItemData();
    if (response == null) {
      print('rrrr');
      emit(hopIntresErrorStates(error: "error"));
    } else {
      if (aboutCat == null) {
        print('wwwvvvvv');
        final items = response.videos;

        // items!.first.. = true;
        aboutCat = items;
        print(aboutCat);
        print('wwwvvvvv');
      }
      emit(ShopIntresSuccessStates());
    }
  }
}
