import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/profile/profile_event.dart';
import 'package:hand_bill/src/blocs/profile/profile_state.dart';
import 'package:hand_bill/src/data/model/profile/profile_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/auth/edit_profile_response_.dart';
import 'package:hand_bill/src/data/response/auth/common_response.dart';
import 'package:hand_bill/src/data/response/auth/profile_response.dart';
import 'package:hand_bill/src/repositories/auth_repository.dart';
import 'package:hand_bill/src/repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository profileRepository = ProfileRepository();

  bool isFetching = false;
  List<GetProfileDataModel>? profile;

  AuthRepository authRepository = AuthRepository();
  late GlobalBloc globalBloc;

  ProfileBloc({required BuildContext context}) : super(ProfileInitialState()) {
    globalBloc = BlocProvider.of<GlobalBloc>(context);
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    // if (event is ProfileFetchDtaEvent) {
    //   yield* _mapFetchProfileDataToState();
    // }
    if (event is ProfileFetchEvent) {
      yield* _mapFetchProfileToState(event);
    }
    if (event is EditProfileEvent) {
      yield* _mapEditProfileToState(event);
    }
    if (event is ChangePasswordEvent) {
      yield* _mapChangePasswordToState(event);
    }
  }

  // Stream<ProfileState> _mapFetchProfileDataToState() async* {
  //   try {
  //     yield ProfileLoadingState();
  //     final ProfileResponse? response = await profileRepository.fetchData();
  //     globalBloc.user = response!.data;
  //     log("parse profile data from db to local >>>>>>> ${globalBloc.user!.toJson()}");
  //     if (response.status!) {
  //       yield ProfileSuccessState(user: response.data);
  //     } else {
  //       yield ProfileErrorState(error: response.message.toString());
  //     }
  //   } catch (e) {
  //     print("$e");
  //   }
  // }

  Stream<ProfileState> _mapFetchProfileToState(ProfileFetchEvent event) async* {
    try {
      yield ProfileLoadingState();
      ProfileResponse? response =
          await profileRepository.fetchUserData(user: event.user);
      globalBloc.user = response!.data as User? ;
      log("parse profile data from db to local >>>>>>> ${globalBloc.user!.toJson()}");
      if (response.status!) {
        yield ProfileSuccessState(user: response.data);
      } else {
        yield ProfileErrorState(error: response.message.toString());
      }
    } catch (e) {
      print("$e");
    }
  }

  Stream<ProfileState> _mapEditProfileToState(EditProfileEvent event) async* {
    try {
      yield EditProfileLoadingState();
      EditProfileResponse? response = await profileRepository.editProfile(
          user: event.user!, image: event.image);
      print(event.user!.phone);
      if (response!.status!) {
        globalBloc.user = response.data;
        print(globalBloc.user!.phone);
        print('yaaaaaaaaraaaaaaab');
        authRepository.setCurrentUser(globalBloc.user);
        yield EditProfileSuccessState(
            user: response.data, message: response.message);
      } else {
        yield EditProfileErrorState(error: response.message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<ProfileState> _mapChangePasswordToState(
      ChangePasswordEvent event) async* {
    yield EditProfileLoadingState();
    CommonResponse? response = await profileRepository.changePassword(
        user: event.user!,
        currentPass: event.currentPassword,
        newPass: event.newPassword);

    if (response!.status!) {
      yield ChangePasswordSuccessState(message: response.message);
    } else {
      yield EditProfileErrorState(error: response.message);
    }
  }
}
