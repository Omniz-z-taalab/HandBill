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
    on<ProfileFetchEvent>(_mapFetchProfileToState);
    on<EditProfileEvent>(_mapEditProfileToState);
    on<ChangePasswordEvent>(_mapChangePasswordToState);
  }

  void _mapFetchProfileToState(
      ProfileFetchEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      ProfileResponse? response =
          await profileRepository.fetchUserData(user: event.user);
      globalBloc.user = response!.data as User?;
      log("parse profile data from db to local >>>>>>> ${globalBloc.user!.toJson()}");
      if (response.status!) {
        emit(ProfileSuccessState(user: response.data));
      } else {
        emit(ProfileErrorState(error: response.message.toString()));
      }
    } catch (e) {
      print("$e");
    }
  }

  void _mapEditProfileToState(
      EditProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(EditProfileLoadingState());
      EditProfileResponse? response = await profileRepository.editProfile(
          user: event.user!, image: event.image);
      print(event.user!.phone);
      if (response!.status!) {
        globalBloc.user = response.data;
        print(globalBloc.user!.phone);
        print('yaaaaaaaaraaaaaaab');
        authRepository.setCurrentUser(globalBloc.user);
        emit(EditProfileSuccessState(
            user: response.data, message: response.message));
      } else {
        emit(EditProfileErrorState(error: response.message));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _mapChangePasswordToState(
      ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    emit(EditProfileLoadingState());
    CommonResponse? response = await profileRepository.changePassword(
        user: event.user!,
        currentPass: event.currentPassword,
        newPass: event.newPassword);

    if (response!.status!) {
      emit(ChangePasswordSuccessState(message: response.message));
    } else {
      emit(EditProfileErrorState(error: response.message));
    }
  }
}
